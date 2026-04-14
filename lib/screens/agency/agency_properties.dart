import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';
import 'package:ejari/utils/image_urls.dart';
import 'package:ejari/widgets/public_profile_nav.dart';

class AgencyPropertiesScreen extends StatelessWidget {
  const AgencyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final list = agencyProperties(aid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('عقارات المكتب'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.agencyAddProperty),
          icon: const Icon(Icons.add),
          label: const Text('إضافة عقار جديد'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final p = list[i];
            final seed = p.primaryImageSeed ?? p.id;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        ejariPlaceholderImage(seed),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(color: EjariColors.borderSubtle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(p.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                        Text(p.location, style: Theme.of(context).textTheme.bodySmall),
                        Text.rich(
                          textAlign: TextAlign.right,
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              const TextSpan(text: 'المالك: '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: InkWell(
                                  onTap: () => pushPublicProfile(context, p.ownerId),
                                  borderRadius: BorderRadius.circular(6),
                                  child: Text(
                                    p.ownerName,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: EjariColors.primary,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.underline,
                                          decorationColor: EjariColors.primary,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('${p.priceMonthly.toStringAsFixed(0)} د.أ / شهر', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: EjariColors.primary)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Chip(label: Text(p.availableNow ? 'شاغر' : 'مؤجر')),
                            const SizedBox(width: 8),
                            Text('${p.ownerRating}'),
                            const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 18),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('تعديل العقار (تجريبي)')),
                                  );
                                },
                                child: const Text('تعديل'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('حذف العقار (تجريبي)')),
                                  );
                                },
                                child: const Text('حذف'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton(
                                onPressed: () => context.push(AppRoutes.propertyPath(p.id)),
                                child: const Text('التفاصيل'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
