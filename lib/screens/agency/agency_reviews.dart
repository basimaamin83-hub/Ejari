import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/agency_app_bar.dart';

class AgencyReviewsScreen extends StatelessWidget {
  const AgencyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aid = ejariSession.user?.agencyId;
    if (aid == null) {
      return const Scaffold(body: Center(child: Text('غير مصرح')));
    }
    final list = agencyReviewsFor(aid);
    final avg = list.isEmpty
        ? 0.0
        : list.fold<double>(0, (s, r) => s + r.stars) / list.length;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: EjariColors.background,
        appBar: agencyGradientAppBar(
          title: const Text('تقييمات المكتب'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: EjariColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: EjariColors.accent.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    avg > 0 ? avg.toStringAsFixed(1) : '—',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 36),
                  const SizedBox(width: 12),
                  const Text('متوسط تقييم المكتب'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'جميع التقييمات',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            ...list.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(r.authorName, textAlign: TextAlign.right),
                    subtitle: Text(r.comment ?? '—', textAlign: TextAlign.right),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < r.stars ? Icons.star_rounded : Icons.star_border_rounded,
                          size: 18,
                          color: i < r.stars ? EjariColors.starFilled : EjariColors.starEmpty,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
