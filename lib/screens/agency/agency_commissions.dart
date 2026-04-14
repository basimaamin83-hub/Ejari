import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/agency_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

class AgencyCommissionsScreen extends StatelessWidget {
  const AgencyCommissionsScreen({super.key});

  static String _fmt(DateTime d) => '${d.year}/${d.month}/${d.day}';

  void _fakeInvoice(BuildContext context, AgencyCommissionRecord c) {
    final label = c.contractId ?? c.id;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم إصدار فاتورة عمولة PDF وهمية — عقد: $label')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final list = agencyCommissionsFor(aid);
    final byOwner = agencyCommissionTotalsDueByLandlord(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('سجل العمولات'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تصدير التقرير (وهمي)')),
                );
              },
              child: const Text('تصدير', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          children: [
            if (byOwner.isNotEmpty) ...[
              Text(
                'إجمالي العمولات المستحقة لكل مالك (غير المدفوعة)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              ...byOwner.entries.map(
                (e) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(e.key, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w700)),
                    trailing: Text(
                      '${e.value.toStringAsFixed(2)} د.أ',
                      style: TextStyle(fontWeight: FontWeight.w900, color: EjariColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'تفصيل العمليات',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(EjariColors.surfaceMuted),
                columns: const [
                  DataColumn(label: Text('فاتورة')),
                  DataColumn(label: Text('الدفع')),
                  DataColumn(label: Text('المبلغ')),
                  DataColumn(label: Text('العمولة %')),
                  DataColumn(label: Text('إيجار سنوي')),
                  DataColumn(label: Text('المالك')),
                  DataColumn(label: Text('العقار')),
                  DataColumn(label: Text('التاريخ')),
                ],
                rows: list
                    .map(
                      (c) => DataRow(
                        cells: [
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.picture_as_pdf_outlined),
                              onPressed: () => _fakeInvoice(context, c),
                              tooltip: 'إصدار فاتورة عمولة',
                            ),
                          ),
                          DataCell(Text(c.paid ? 'مدفوع' : 'مستحق')),
                          DataCell(Text(c.amountDue.toStringAsFixed(2))),
                          DataCell(Text('${c.commissionPercent}')),
                          DataCell(Text(c.annualRent.toStringAsFixed(0))),
                          DataCell(SizedBox(width: 100, child: Text(c.landlordName, maxLines: 2))),
                          DataCell(SizedBox(width: 140, child: Text(c.propertyTitle, maxLines: 2))),
                          DataCell(Text(_fmt(c.contractDate))),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
