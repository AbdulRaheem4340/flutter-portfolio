import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchHelpers {
  static const String email = 'ar4942876@gmail.com';
  static const String github = 'https://github.com/AbdulRaheem4340/';
  static const String linkedIn =
      'https://www.linkedin.com/in/abdul-raheem-7b0486370';

  
  static const String resumeUrl =
      'https://drive.google.com/file/d/YOUR_RESUME_FILE_ID/view?usp=sharing';

  static Future<void> openEmail({
    BuildContext? context,
    String subject = 'Hello Abdul — Flutter Opportunity',
    String body =
        'Hi Abdul,\n\nI saw your portfolio and would like to connect.\n\n',
  }) async {
    final gmail = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1'
      '&to=${Uri.encodeComponent(email)}'
      '&su=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(body)}',
    );

    final gmailOk = await _open(gmail);
    if (gmailOk) return;

    final mailto = Uri(
      scheme: 'mailto',
      path: email,
      query: _query({'subject': subject, 'body': body}),
    );
    final mailtoOk = await _open(mailto);
    if (mailtoOk) return;


    if (context != null && context.mounted) {
      await copyEmail(context: context);
    } else {
      await copyEmail();
    }
  }

  static Future<void> openDemoRequest(
    String projectName, {
    BuildContext? context,
  }) async {
    await openEmail(
      context: context,
      subject: 'Demo Request - $projectName',
      body: 'Hi Abdul,\n\nI\'d like to see a demo of $projectName.\n\nThanks!',
    );
  }

  static Future<void> openUrl(String url) async {
    await _open(Uri.parse(url));
  }

  // static Future<void> openResume({BuildContext? context}) async {
  //   if (resumeUrl.contains('YOUR_RESUME_FILE_ID')) {
  //     // No resume link set yet
  //     if (context != null && context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Resume link not added yet. Ask Abdul for CV.'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //     return;
  //   }
  //   await openUrl(resumeUrl);
  // }

  static Future<void> copyEmail({BuildContext? context}) async {
    await Clipboard.setData(const ClipboardData(text: email));
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email copied: $email'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<bool> _open(Uri uri) async {
    try {
      if (kIsWeb) {
        return await launchUrl(uri, webOnlyWindowName: '_blank');
      }
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static String _query(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
