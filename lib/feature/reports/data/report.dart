import 'dart:convert';

import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/feature/link/link_document.dart';
import 'package:voterseye/logging.dart';
import 'package:http/http.dart';

final _reportAdditionClient = Client();

typedef ShareReportsResponse = ({
  String attestationId,
  String publicJWK,
  String receiverId
});

class Report {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final VerifiedFile file;
  final VerifiedDocument document;

  const Report({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.file,
    required this.document,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      file: VerifiedFile.fromJson(json['file'] as Map<String, dynamic>),
      document:
          VerifiedDocument.fromJson(json['document'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'file': file.toJson(),
      'document': document.toJson(),
    };
  }

  Future<bool> shareProof(
    AuthManager auth,
    ShareReportsResponse recipientResponse,
  ) async {
    try {
      final publicKey = auth.publicKey ??
          "0x925978064717107d621d0fb2c8e68b8809f8cfd8b046c84d0fee6b68cbc5f68e";
      final response = await _reportAdditionClient.post(
        Uri.parse(
            "${String.fromEnvironment('RECLAIM_BACKEND_URL', defaultValue: 'https://aa40-27-131-162-179.ngrok-free.app')}/api/signAttestion"),
        body: json.encode({
          "imgProof": file.attestationOutput.toJson(),
          "aiProof": document.attestationOutput.toJson(),
          "fromAddress": publicKey,
          "toAddress": recipientResponse.receiverId,
          "referenceId": recipientResponse.attestationId,
          "publicJWK": recipientResponse.publicJWK,
        }),
      );
      $logger.child('shareProof').info({
        'status': response.statusCode,
        'body': response.body,
      });
      return response.statusCode == 200;
    } catch (e, s) {
      $logger.child('shareProof').severe('failed', e, s);
      rethrow;
    }
  }
}
