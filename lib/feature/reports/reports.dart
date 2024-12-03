import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/feature/link/link_document.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'data/report.dart';

class UserReportsController extends Notifier<List<Report>> {
  @override
  List<Report> build() {
    Future.microtask(_hydrate);
    return const [];
  }

  void _hydrate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reports = preferences.getStringList('reports') ?? [];
    state =
        reports.map((report) => Report.fromJson(json.decode(report))).toList();
  }

  void _commit(List<Report> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('reports',
        value.map((report) => json.encode(report.toJson())).toList());
  }

  @override
  set state(List<Report> value) {
    _commit(value);
    super.state = value;
  }

  void addReport(
    VerifiedFile file,
    VerifiedDocument document,
  ) {
    final properties = document.properties;
    final report = Report(
      id: const Uuid().v4(),
      title: properties?['report_title'] ?? '',
      description: properties?['description'] ?? '',
      createdAt: DateTime.now(),
      file: file,
      document: document,
    );

    print('proof ${ref.read(authProvider).keys?.publicKey}');

    state = [
      report,
      ...state,
    ];
  }
}

final userReportsProvider =
    NotifierProvider<UserReportsController, List<Report>>(
  () => UserReportsController(),
);
