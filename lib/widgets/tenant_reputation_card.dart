import 'package:flutter/material.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/format_date_ar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/report_review_dialog.dart';

/// بطاقة «سجل المستأجر» لعرض المالك عند طلب الإيجار.
class TenantReputationCard extends StatelessWidget {
  const TenantReputationCard({super.key, required this.tenantId});

  final String tenantId;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ratingsNotifier,
      builder: (context, _) {
        final snap = ratingsNotifier.tenantSnapshot(tenantId);
        return _TenantReputationBody(snap: snap);
      },
    );
  }
}

class _TenantReputationBody extends StatelessWidget {
  const _TenantReputationBody({required this.snap});

  final TenantReputationSnapshot snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EjariColors.primary.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'سجل المستأجر',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                snap.averageRating > 0 ? snap.averageRating.toStringAsFixed(1) : '—',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: EjariColors.primary,
                    ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 28),
              const SizedBox(width: 8),
              const Text('متوسط التقييم من 5'),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'الالتزام بالدفع: ${snap.paymentCompliancePercent}% من الدفعات في الموعد',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'العقود السابقة: ${snap.pastContractsCount}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'الشكاوى المقدمة ضده: ${snap.complaintsCount}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (snap.violationsNote != null && snap.violationsNote!.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'مخالفات: ${snap.violationsNote}',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            'آخر التقييمات من مالكين سابقين',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          if (snap.lastReviews.isEmpty)
            Text(
              'لا توجد تقييمات سابقة.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            )
          else
            ...snap.lastReviews.map((r) => _TenantReviewMiniTile(review: r)),
        ],
      ),
    );
  }
}

class _TenantReviewMiniTile extends StatelessWidget {
  const _TenantReviewMiniTile({required this.review});

  final TenantReview review;

  @override
  Widget build(BuildContext context) {
    final c = review.criteria;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.flag_outlined, size: 20),
                  tooltip: 'إبلاغ عن تقييم مسيء',
                  onPressed: () => showReportReviewDialog(context, reviewId: review.id),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => pushPublicProfile(context, review.landlordId),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      review.landlordDisplayName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: EjariColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: EjariColors.primary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (i) => Icon(
                    i < review.overallStars ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 16,
                    color: i < review.overallStars ? EjariColors.starFilled : EjariColors.starEmpty,
                  ),
                ),
              ],
            ),
            Text(
              formatDateAr(review.reviewedAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            ),
            if (review.comment != null && review.comment!.trim().isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                review.comment!,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35),
              ),
            ],
            const SizedBox(height: 8),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'تفاصيل المعايير',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _line('الالتزام بالدفع', c.paymentTimeliness),
                        _line('المحافظة على العقار', c.propertyCare),
                        _line('التعاون', c.cooperation),
                        _line('الالتزام بالعقد', c.contractCompliance),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _line(String label, int stars) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('$stars/5', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
