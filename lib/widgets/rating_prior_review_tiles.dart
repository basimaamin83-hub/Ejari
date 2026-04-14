import 'package:flutter/material.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/format_date_ar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';

/// بطاقة تقييم سابق للمستأجر (من مالك سابق) — شاشة تقييم المستأجر.
class PriorTenantReviewTile extends StatelessWidget {
  const PriorTenantReviewTile({super.key, required this.review});

  final TenantReview review;

  @override
  Widget build(BuildContext context) {
    final c = review.criteria;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => pushPublicProfile(context, review.landlordId),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    review.landlordDisplayName.isNotEmpty ? review.landlordDisplayName : 'مالك سابق',
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
          const SizedBox(height: 4),
          Text(
            formatDateAr(review.reviewedAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'المعايير: ${c.summaryNumbers}',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (review.comment != null && review.comment!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              review.comment!,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35),
            ),
          ],
        ],
      ),
    );
  }
}

/// بطاقة تقييم سابق للمالك (من مستأجر سابق) — شاشة تقييم المالك.
class PriorLandlordReviewTile extends StatelessWidget {
  const PriorLandlordReviewTile({super.key, required this.review});

  final LandlordReview review;

  @override
  Widget build(BuildContext context) {
    final c = review.criteria;
    final name = review.hideTenantName ? 'مستأجر سابق' : review.tenantDisplayName;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => pushPublicProfile(context, review.tenantId),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    name,
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
          const SizedBox(height: 4),
          Text(
            formatDateAr(review.reviewedAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'المعايير: ${c.summaryNumbers}',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (review.comment != null && review.comment!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              review.comment!,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35),
            ),
          ],
        ],
      ),
    );
  }
}
