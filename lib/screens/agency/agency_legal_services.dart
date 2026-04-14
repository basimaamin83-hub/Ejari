import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/agency_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

class AgencyLegalServicesScreen extends StatefulWidget {
  const AgencyLegalServicesScreen({super.key});

  @override
  State<AgencyLegalServicesScreen> createState() => _AgencyLegalServicesScreenState();
}

class _AgencyLegalServicesScreenState extends State<AgencyLegalServicesScreen> {
  final List<AgencyLegalConsultRecord> _extraConsults = [];
  final _descCtrl = TextEditingController();
  String _issueType = 'نزاع تعاقدي';

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  void _fakeDownloadPdf(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تحميل ملف PDF وهمي: $title')),
    );
  }

  void _submitConsult() {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) return;
    if (_descCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال وصف المشكلة')),
      );
      return;
    }
    setState(() {
      _extraConsults.insert(
        0,
        AgencyLegalConsultRecord(
          id: 'leg-new-${DateTime.now().millisecondsSinceEpoch}',
          agencyId: aid,
          issueType: _issueType,
          description: _descCtrl.text.trim(),
          submittedAt: DateTime.now(),
          status: 'مُرسل للمشرف',
        ),
      );
    });
    _descCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلبك للمشرف')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }

    final seeded = agencyLegalConsultsFor(aid);
    final allConsults = [..._extraConsults, ...seeded];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('الخدمات القانونية'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Text(
              'مكتبة نماذج العقود (PDF وهمي)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            _pdfTile(context, 'نموذج عقد إيجار سكني — الأردن', Icons.home_work_outlined, () {
              _fakeDownloadPdf('عقد_إيجار_سكني.pdf');
            }),
            _pdfTile(context, 'نموذج عقد بيع عقار', Icons.handshake_outlined, () {
              _fakeDownloadPdf('عقد_بيع.pdf');
            }),
            _pdfTile(context, 'اتفاقية إدارة أملاك للمكاتب العقارية', Icons.business_center_outlined, () {
              _fakeDownloadPdf('اتفاقية_إدارة_أملاك.pdf');
            }),
            const SizedBox(height: 24),
            Text(
              'طلب استشارة قانونية',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      // ignore: deprecated_member_use
                      value: _issueType,
                      decoration: const InputDecoration(
                        labelText: 'نوع المشكلة',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'نزاع تعاقدي', child: Text('نزاع تعاقدي')),
                        DropdownMenuItem(value: 'إخلاء وتعويض', child: Text('إخلاء وتعويض')),
                        DropdownMenuItem(value: 'صياغة عقد', child: Text('صياغة عقد')),
                        DropdownMenuItem(value: 'أخرى', child: Text('أخرى')),
                      ],
                      onChanged: (v) => setState(() => _issueType = v ?? _issueType),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descCtrl,
                      decoration: const InputDecoration(
                        labelText: 'وصف المشكلة',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _submitConsult,
                      icon: const Icon(Icons.send_outlined),
                      label: const Text('إرسال الطلب'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'سجل الطلبات',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            if (allConsults.isEmpty)
              const Text('لا توجد طلبات.')
            else
              ...allConsults.map(
                (c) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(c.issueType, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(
                      '${c.description}\n${_fmt(c.submittedAt)} — ${c.status}',
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

  Widget _pdfTile(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: EjariColors.primary),
        title: Text(label, textAlign: TextAlign.right),
        trailing: const Icon(Icons.picture_as_pdf_outlined, color: Colors.redAccent),
        onTap: onTap,
      ),
    );
  }
}
