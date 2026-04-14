import 'package:flutter/material.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/format_date_ar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/report_review_dialog.dart';

class LandlordReviewTile extends StatelessWidget {
  const LandlordReviewTile({
    super.key,
    required this.review,
    this.initiallyExpanded = false,
  });

  final LandlordReview review;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final c = review.criteria;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
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
                  onTap: () => pushPublicProfile(context, review.tenantId),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      review.reviewerVisibleName,
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
                    size: 18,
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
            if (review.comment != null && review.comment!.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
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
                initiallyExpanded: initiallyExpanded,
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
                        _criterionLine('التعاون والتواصل', c.cooperation),
                        _criterionLine('صيانة العقار', c.maintenance),
                        _criterionLine('الاستجابة للطلبات', c.responsiveness),
                        _criterionLine('الشفافية', c.transparency),
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

  static Widget _criterionLine(String label, int stars) {
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
