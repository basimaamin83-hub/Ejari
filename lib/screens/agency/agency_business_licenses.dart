import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/agency_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

class AgencyBusinessLicensesScreen extends StatefulWidget {
  const AgencyBusinessLicensesScreen({super.key});

  @override
  State<AgencyBusinessLicensesScreen> createState() => _AgencyBusinessLicensesScreenState();
}

class _AgencyBusinessLicensesScreenState extends State<AgencyBusinessLicensesScreen> {
  final _nameCtrl = TextEditingController();
  final _activityCtrl = TextEditingController();
  final _buildingCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final List<AgencyBusinessLicenseRequest> _extra = [];

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _activityCtrl.dispose();
    _buildingCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) return;
    if (_nameCtrl.text.trim().isEmpty ||
        _activityCtrl.text.trim().isEmpty ||
        _buildingCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة اسم العقار والنشاط ورقم المبنى')),
      );
      return;
    }
    setState(() {
      _extra.insert(
        0,
        AgencyBusinessLicenseRequest(
          id: 'lic-new-${DateTime.now().millisecondsSinceEpoch}',
          agencyId: aid,
          propertyName: _nameCtrl.text.trim(),
          businessActivity: _activityCtrl.text.trim(),
          buildingNumber: _buildingCtrl.text.trim(),
          submittedAt: DateTime.now(),
          status: 'مُرسل للبلدية',
        ),
      );
    });
    _nameCtrl.clear();
    _activityCtrl.clear();
    _buildingCtrl.clear();
    _notesCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلبك إلى البلدية')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }

    final seeded = agencyLicenseRequestsFor(aid);
    final rows = [..._extra, ...seeded];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('التراخيص التجارية — البلدية'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Text(
              'طلب مساعدة في إصدار ترخيص بلدي (عقار تجاري)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'يُستخدم هذا النموذج لمتابعة إجراءات الترخيص مع البلدية المعنيّة في الأردن (وضع تجريبي).',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'اسم العقار / الوحدة',
                        border: OutlineInputBorder(),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _activityCtrl,
                      decoration: const InputDecoration(
                        labelText: 'النشاط التجاري',
                        border: OutlineInputBorder(),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _buildingCtrl,
                      decoration: const InputDecoration(
                        labelText: 'رقم المبنى / القطعة',
                        border: OutlineInputBorder(),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesCtrl,
                      decoration: const InputDecoration(
                        labelText: 'ملاحظات إضافية (اختياري)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.send_outlined),
                      label: const Text('إرسال الطلب'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'طلبات سابقة (وهمية)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            ...rows.map(
              (r) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(r.propertyName, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text(
                    'النشاط: ${r.businessActivity}\nالمبنى: ${r.buildingNumber}\n'
                    '${_fmt(r.submittedAt)} — ${r.status}',
                    textAlign: TextAlign.right,
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
