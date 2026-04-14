import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/widgets/landlord_review_tile.dart';

/// قسم «سجل تقييمات المالك» في صفحة تفاصيل العقار.
class LandlordReviewsSection extends StatelessWidget {
  const LandlordReviewsSection({super.key, required this.ownerId});

  final String ownerId;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ratingsNotifier,
      builder: (context, _) {
        final avg = ratingsNotifier.averageLandlordRating(ownerId);
        final list = ratingsNotifier.lastLandlordReviews(ownerId, limit: 10);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'سجل تقييمات المالك',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: EjariColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        avg > 0 ? avg.toStringAsFixed(1) : '—',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: EjariColors.primary,
                            ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'متوسط التقييم من 5',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'يساعدك على معرفة تجربة المستأجرين السابقين مع هذا المالك.',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'لا توجد تقييمات بعد.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                ),
              )
            else
              ...list.map((r) => LandlordReviewTile(review: r)),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.push(AppRoutes.landlordReviewsFullPath(ownerId)),
                child: const Text('عرض كل التقييمات'),
              ),
            ),
          ],
        );
      },
    );
  }
}
