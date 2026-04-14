import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

class AgencySettingsScreen extends StatefulWidget {
  const AgencySettingsScreen({super.key});

  @override
  State<AgencySettingsScreen> createState() => _AgencySettingsScreenState();
}

class _AgencySettingsScreenState extends State<AgencySettingsScreen> {
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _address;
  late TextEditingController _commission;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    final aid = ejariSession.user?.agencyId ?? kAgency1Id;
    final p = agencyProfileFor(aid);
    _name = TextEditingController(text: p.name);
    _phone = TextEditingController(text: p.phone);
    _email = TextEditingController(text: p.email);
    _address = TextEditingController(text: p.address);
    _commission = TextEditingController(text: p.defaultCommissionPercent.toString());
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    _commission.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final p = agencyProfileFor(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('إعدادات المكتب'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('رقم الرخصة: ${p.licenseNumber}', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            TextField(
              controller: _name,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(labelText: 'اسم المكتب', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phone,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(labelText: 'الهاتف', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _email,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(labelText: 'البريد', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _address,
              minLines: 2,
              maxLines: 3,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(labelText: 'العنوان', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commission,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'نسبة العمولة الافتراضية (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'تغيير كلمة المرور',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _password,
              obscureText: true,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'كلمة مرور جديدة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ الإعدادات (وهمي)')),
                );
              },
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
