import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchPhoneDialer(BuildContext context, String phone) async {
  final normalized = phone.replaceAll(RegExp(r'[^\d+]'), '');
  final uri = Uri.parse('tel:$normalized');
  if (!await launchUrl(uri)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر فتح تطبيق الاتصال')),
      );
    }
  }
}

Future<void> launchWhatsApp(BuildContext context, String phone) async {
  var digits = phone.replaceAll(RegExp(r'\D'), '');
  if (digits.startsWith('0')) digits = digits.substring(1);
  if (!digits.startsWith('962')) digits = '962$digits';
  final uri = Uri.parse('https://wa.me/$digits');
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر فتح واتساب')),
      );
    }
  }
}
