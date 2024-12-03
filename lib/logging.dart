import 'package:logging/logging.dart';

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:reclaim_flutter_sdk/logging/data/log.dart';
import 'package:reclaim_flutter_sdk/utils/dio.dart';
import 'package:reclaim_flutter_sdk/utils/source/source.dart';
import 'package:reclaim_flutter_sdk/attestor_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

export 'package:logging/logging.dart';

import 'common/constants.dart';

final logging = Logger(appName);

extension LoggerExtension on Logger {
  /// Create a new child [Logging] instance with a [name].
  ///
  /// The full name of this new Logging will be this logging's full name + the [name].
  Logger child(String name) {
    return Logger('$fullName.$name');
  }
}

extension LoggerObjectExtension on Object {
  Logger get $logger => logging.child(runtimeType.toString());
}

final _dioClient = buildDio();

final _loggingApi = Uri.parse(
  'https://logs.reclaimprotocol.org/api/business-logs/logDump',
);

typedef _BufferLogEntry = ({LogRecord record, ConsumerIdentity? identity});

String _formatStackTrace({
  StackTrace? stackTrace,
  int? maxFrames,
}) {
  if (stackTrace == null) {
    stackTrace = StackTrace.current;
  } else {
    stackTrace = FlutterError.demangleStackTrace(stackTrace);
  }
  Iterable<String> lines = stackTrace.toString().trimRight().split('\n');
  if (kIsWeb && lines.isNotEmpty) {
    // Remove extra call to StackTrace.current for web platform.
    // TODO(mushaheed): remove when https://github.com/flutter/flutter/issues/37635 is addressed.
    lines = lines.skipWhile((String line) {
      return line.contains('StackTrace.current') ||
          line.contains('dart-sdk/lib/_internal') ||
          line.contains('logging/logging') ||
          line.contains('dart:sdk_internal');
    });
  }
  if (maxFrames != null) {
    lines = lines.take(maxFrames);
  }
  return lines.join('\n');
}

Future<String> _getDeviceLoggingId() async {
  final prefs = await SharedPreferences.getInstance();
  const key = '_DEVICE_LOGGING_ID';
  final value = prefs.getString(key);
  if (value != null) return value;
  final id = const Uuid().v4().toString();
  await prefs.setString(key, id);
  return id;
}

Future<void> _sendLogEntries(
  List<_BufferLogEntry> entries, {
  required ConsumerIdentity fallbackConsumerIdentity,
  Uri? loggingUrl,
}) async {
  try {
    loggingUrl ??= _loggingApi;
    final logs = entries.map((e) {
      final logLineBuffer = StringBuffer(e.record.message);

      final error = e.record.error;

      if (error != null) {
        logLineBuffer.write('\n');
        logLineBuffer.writeln(error);
        if (e.record.stackTrace != null) {
          logLineBuffer.write('\n');
          logLineBuffer.writeln(_formatStackTrace(
            stackTrace: e.record.stackTrace,
          ));
        }
      }

      return LogEntry(
        consumerIdentity: fallbackConsumerIdentity.merge(e.identity),
        logLine: logLineBuffer.toString(),
        sequence: e.record.sequenceNumber,
        type: e.record.loggerName,
        time: e.record.time,
      );
    }).toList();

    final firstAppId = entries.firstOrNull?.identity?.appId.trim();
    final appId = firstAppId != null && firstAppId.isNotEmpty
        ? firstAppId
        : fallbackConsumerIdentity.appId;

    await _dioClient.postUri(
      loggingUrl,
      options: Options(
        headers: const {
          'content-type': 'application/json',
        },
      ),
      data: json.encode({
        'logs': logs,
        'source': await getClientSource(appId),
        'deviceId': await _getDeviceLoggingId(),
      }),
    );
  } catch (e) {
    throw Exception('Failed to send logs to url $loggingUrl: $e');
  }
}

List<_BufferLogEntry> _buffer = [];
ConsumerIdentity? latestConsumerIdentity;

void _sendAndFlushLogs(_) async {
  if (_buffer.isEmpty) return;

  final identity = latestConsumerIdentity;
  if (identity == null ||
      // wait for session id to get generated
      identity.sessionId.isEmpty) return;

  final logs = _buffer;

  _buffer = [];

  try {
    await _sendLogEntries(
      logs,
      fallbackConsumerIdentity: identity,
    );
    logs.clear();
  } catch (e, s) {
    if (kDebugMode) {
      debugPrintThrottled('Failed to send logs: $e');
      debugPrintThrottled(_formatStackTrace(stackTrace: s));
    }
    // re-insert logs that we weren't able to send
    _buffer.insertAll(0, logs);
  }
}

final _logDateFormat = DateFormat('hh:mm:ss aa');

void _onLogsToConsole(LogRecord record) {
  final formattedTime = _logDateFormat.format(record.time);

  final label =
      '$formattedTime ${record.level.name} ${record.loggerName} (${record.sequenceNumber})';

  final message = record.message;
  debugPrintThrottled('$label $message'.trim());
  final error = record.error;
  if (error != null) debugPrintThrottled('$label [Error] $error');
  if (record.level >= Level.WARNING) {
    debugPrintThrottled(label);
    debugPrintThrottled(
      _formatStackTrace(
        stackTrace: record.stackTrace,
        maxFrames: 30,
      ),
    );
  }
}

void _onLogRecord(LogRecord record) {
  if (!kReleaseMode) {
    _onLogsToConsole(record);
  }

  _buffer.add((
    record: record,
    identity: latestConsumerIdentity,
  ));
}

bool _isInitialized = false;

bool? _oldIsDebug;
void _onLogLevelChange(Level? level) {
  _saveLogLevel(level);
  if (level == null) return;
  final isDebug = level < Level.INFO;
  if (isDebug != _oldIsDebug) {
    _oldIsDebug = isDebug;
    AttestorWebview.instance.setAttestorDebugLevel(isDebug ? 'debug' : 'info');
  }
}

const _logLevelPrefKey = 'reclaim_flutter_sdk#log_level';

Future<Level> _loadSavedLevel() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(_logLevelPrefKey);
  if (value == null) return Level.INFO;
  for (var level in Level.LEVELS) {
    if (level.value == value) {
      return level;
    }
  }
  return Level(value.toString(), value);
}

void _saveLogLevel(Level? level) async {
  final prefs = await SharedPreferences.getInstance();
  if (level == null) {
    await prefs.remove(_logLevelPrefKey);
    return;
  }
  await prefs.setInt(_logLevelPrefKey, level.value);
}

void initializeAppLogging() async {
  if (_isInitialized) return;
  _isInitialized = true;

  hierarchicalLoggingEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  // TODO(mushaheed): Should we record all logs from the app or just logs under 'reclaim_flutter_sdk'?
  Logger.root.onRecord.listen(_onLogRecord);
  logging.onLevelChanged.listen(_onLogLevelChange);
  logging.level = await _loadSavedLevel();

  final platformDispatcherLogger = logging.child('PlatformDispatcher');
  PlatformDispatcher.instance.onError = (e, s) {
    platformDispatcherLogger.severe('Failed', e, s);
    return true;
  };
  final flutterErrorLogger = logging.child('FlutterError');
  FlutterError.onError = (error) {
    flutterErrorLogger.warning(error.toString(), error.exception, error.stack);
    FlutterError.presentError(error);
  };

  // an always alive periodic timer
  Timer.periodic(
    const Duration(seconds: 5),
    _sendAndFlushLogs,
  );
}
