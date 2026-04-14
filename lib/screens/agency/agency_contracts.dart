import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';

class AgencyContractsScreen extends StatelessWidget {
  const AgencyContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final list = agencyContractsFor(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('العقود'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final c = list[i];
            final statusLabel = c.status == 'active' ? 'نشط' : 'منتهٍ';
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('رقم العقد: ${c.id}', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text('العقار: ${c.propertyTitle}'),
                    Text.rich(
                      textAlign: TextAlign.right,
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(text: 'المستأجر: '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: c.tenantId != null
                                ? InkWell(
                                    onTap: () => pushPublicProfile(context, c.tenantId!),
                                    borderRadius: BorderRadius.circular(6),
                                    child: Text(
                                      c.tenantName,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: EjariColors.primary,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.underline,
                                            decorationColor: EjariColors.primary,
                                          ),
                                    ),
                                  )
                                : Text(c.tenantName, style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.right,
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(text: 'المالك: '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: c.landlordId != null
                                ? InkWell(
                                    onTap: () => pushPublicProfile(context, c.landlordId!),
                                    borderRadius: BorderRadius.circular(6),
                                    child: Text(
                                      c.landlordName,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: EjariColors.primary,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.underline,
                                            decorationColor: EjariColors.primary,
                                          ),
                                    ),
                                  )
                                : Text(c.landlordName, style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                    Text('من ${c.startDate.year}/${c.startDate.month}/${c.startDate.day} إلى ${c.endDate.year}/${c.endDate.month}/${c.endDate.day}'),
                    Text('الإيجار الشهري: ${c.monthlyRent.toStringAsFixed(0)} د.أ'),
                    Text('نسبة العمولة: ${c.commissionPercent}٪'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تحميل PDF: ${c.pdfUrl}')),
                            );
                          },
                          icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                          label: const Text('PDF'),
                        ),
                        Chip(label: Text(statusLabel)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تجديد العقد بالنيابة (وهمي) — يُرسل للطرفين')),
                          );
                        },
                        child: const Text('تجديد العقد'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
