import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/logging.dart';
import 'package:reclaim_flutter_sdk/attestor_webview.dart';
import 'package:reclaim_flutter_sdk/reclaim_flutter_sdk.dart';

class VerifiedFile {
  Map<String, dynamic>? get properties {
    final response = json.decode(
      attestationOutput.claimData.context,
    )['extractedParameters'];
    $logger.child('VerifiedDocument.response').info(response);
    return response;
    // final data = json.decode(response['data']);
    // final choices = data['choices'] as List?;
    // if (choices == null || choices.isEmpty) {
    //   return null;
    // }
    // final firstChoice =
    //     choices.firstWhereOrNull((choice) => choice['index'] == 0);
    // if (firstChoice == null) {
    //   return null;
    // }
    // final content = firstChoice['message']['content'];
    // if (content is! String) return null;
    // final jsonContent =
    //     content.substring(content.indexOf('{'), content.lastIndexOf('}') + 1);
    // return json.decode(jsonContent);
  }

  final CreateClaimOutput attestationOutput;

  VerifiedFile({
    required this.attestationOutput,
  });

  String get base64Data {
    return json.decode(
        attestationOutput.claimData.context)['extractedParameters']['data'];
  }

  String get documentUrl {
    return 'data:image/png;base64,$base64Data';
  }

  factory VerifiedFile.fromJson(Map<String, dynamic> json) {
    return VerifiedFile(attestationOutput: CreateClaimOutput.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return attestationOutput.toJson();
  }
}

class VerifiedDocument {
  final CreateClaimOutput attestationOutput;
  Map<String, dynamic>? get properties {
    final response = json.decode(
      attestationOutput.claimData.context,
    )['extractedParameters'];
    $logger.child('VerifiedDocument.response').info(response);
    final data = json.decode(response['data']);
    final choices = data['choices'] as List?;
    if (choices == null || choices.isEmpty) {
      return null;
    }
    final firstChoice =
        choices.firstWhereOrNull((choice) => choice['index'] == 0);
    if (firstChoice == null) {
      return null;
    }
    final content = firstChoice['message']['content'];
    if (content is! String) return null;
    final jsonContent =
        content.substring(content.indexOf('{'), content.lastIndexOf('}') + 1);
    return json.decode(jsonContent);
  }

  const VerifiedDocument({required this.attestationOutput});

  factory VerifiedDocument.fromJson(Map<String, dynamic> json) {
    return VerifiedDocument(
        attestationOutput: CreateClaimOutput.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return attestationOutput.toJson();
  }
}

class LinkDocumentVerificationUpdate {
  final Map<String, dynamic> info;

  const LinkDocumentVerificationUpdate({required this.info});
}

class LinkDocumentFileVerificationUpdate {
  final Map<String, dynamic> file;

  const LinkDocumentFileVerificationUpdate({required this.file});
}

class LinkDocumentService {
  final Ref ref;

  AuthManager get auth => ref.read(authProvider.notifier);

  const LinkDocumentService({required this.ref});

  static const _reclaimOpenAiApiKey =
      String.fromEnvironment('RECLAIM_OPENAI_API_KEY');

  Future<VerifiedFile> getFileAttestation(
    String fileUrl,
    void Function(LinkDocumentFileVerificationUpdate data) onUpdate,
  ) async {
    final output = await AttestorWebview.instance.createClaim(
      {
        "name": "httpb64",
        "params": {
          "method": "GET",
          "url": fileUrl,
          "responseMatches": [
            {"type": "regex", "value": "(?<data>.*)"}
          ],
        },
        "secretParams": {
          "paramValues": "",
          "headers": {},
          "cookieStr": "",
          "authorisationHeader": "",
        },
        "ownerPrivateKey":
            "0x925978064717107d621d0fb2c8e68b8809f8cfd8b046c84d0fee6b68cbc5f68e",
        "client": {
          "url": 'wss://witness.reclaimprotocol.org/ws',
        },
      },
      (update) {
        onUpdate(LinkDocumentFileVerificationUpdate(file: update));
      },
      options: CreateClaimOptions(
        isComputeProofLocalEnabled: true,
      ),
    );
    return VerifiedFile(attestationOutput: output);
  }

  Future<VerifiedDocument> getDocument(
    String documentUrl,
    VerifiedFile file,
    void Function(
      LinkDocumentVerificationUpdate data,
    ) onUpdate,
  ) async {
    final imageUrl = documentUrl; // TODO: Make it work with file.documentUrl.

    final output = await AttestorWebview.instance.createClaim(
      {
        "name": "http",
        "params": {
          "method": "POST",
          "url": "https://api.openai.com/v1/chat/completions",
          "headers": {"Content-Type": "application/json"},
          "responseMatches": [
            {"type": "regex", "value": "(?<data>.*)"}
          ],
          "responseRedactions": [
            {"regex": "(?<data>.*)"}
          ],
          "body": json.encode(
            {
              "stream": false,
              "model": "gpt-4o-mini",
              "messages": [
                {
                  "role": "user",
                  "content": [
                    {
                      "type": "text",
                      "text":
                          "Determine if the person has the disease for example: HAV. Return the result in JSON format with the person's name and a field indicating whether they are positive (true/false). For example:\n                         { \"name\": \"John\", \"report_title\": \"HAV Report\", \"description\": \"HAV Report\", \"isPositive\":\"true/false\"} Provide the output in this format"
                    },
                    {
                      "type": "image_url",
                      "image_url": {
                        "url": imageUrl,
                        "detail": "high",
                      },
                    },
                  ],
                },
              ],
            },
          ),
        },
        "secretParams": {
          "paramValues": "",
          "headers": {
            "Authorization": "Bearer $_reclaimOpenAiApiKey",
            "Content-Type": "application/json",
          },
          "authorisationHeader": ""
        },
        "ownerPrivateKey": //auth.state.keys?.publicKey ??
            "0x925978064717107d621d0fb2c8e68b8809f8cfd8b046c84d0fee6b68cbc5f68e",
        "client": {
          "url": "wss://witness.reclaimprotocol.org/ws",
        },
      },
      (update) {
        onUpdate(LinkDocumentVerificationUpdate(info: update));
      },
      options: CreateClaimOptions(
        isComputeProofLocalEnabled: true,
      ),
    );
    $logger
        .child('LinkDocumentService.getDocument')
        .info('Document verified', json.encode(output));
    return VerifiedDocument(attestationOutput: output);
  }
}

final linkDocumentServiceProvider = Provider((ref) {
  return LinkDocumentService(ref: ref);
});
