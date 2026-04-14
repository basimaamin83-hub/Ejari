import 'package:flutter/material.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/format_date_ar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/report_review_dialog.dart';

/// بطاقة تقييم واحدة في الملف العام أو شاشة «كل التقييمات».
class PublicProfileReviewEntry extends StatelessWidget {
  const PublicProfileReviewEntry({
    super.key,
    required this.entry,
    this.agencyCriteriaLabels = false,
    this.initiallyExpanded = false,
  });

  final UserReceivedRatingEntry entry;
  /// إذا true تُعرض تسميات مناسبة للمكتب العقاري بدل تسميات المالك.
  final bool agencyCriteriaLabels;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final lc = entry.landlordCriteria;
    final tc = entry.tenantCriteria;
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
                  tooltip: 'إبلاغ',
                  onPressed: () => showReportReviewDialog(context, reviewId: entry.id),
                ),
                const Spacer(),
                if (entry.reviewerUserId != null)
                  InkWell(
                    onTap: () => pushPublicProfile(context, entry.reviewerUserId!),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(
                        entry.reviewerName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: EjariColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: EjariColors.primary,
                            ),
                      ),
                    ),
                  )
                else
                  Text(
                    entry.reviewerName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (i) => Icon(
                    i < entry.overallStars ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 18,
                    color: i < entry.overallStars ? EjariColors.starFilled : EjariColors.starEmpty,
                  ),
                ),
              ],
            ),
            Text(
              formatDateAr(entry.reviewedAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
            ),
            if (entry.comment != null && entry.comment!.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                entry.comment!,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35),
              ),
            ],
            if (lc != null) ...[
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
                        children: agencyCriteriaLabels
                            ? [
                                _criterionLine('الخدمة والاحترافية', lc.cooperation),
                                _criterionLine('جودة العروض والمتابعة', lc.maintenance),
                                _criterionLine('سرعة الاستجابة', lc.responsiveness),
                                _criterionLine('الشفافية في العمولة والشروط', lc.transparency),
                              ]
                            : [
                                _criterionLine('التعاون والتواصل', lc.cooperation),
                                _criterionLine('صيانة العقار', lc.maintenance),
                                _criterionLine('الاستجابة للطلبات', lc.responsiveness),
                                _criterionLine('الشفافية', lc.transparency),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (tc != null) ...[
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
                          _criterionLine('الالتزام بالدفع', tc.paymentTimeliness),
                          _criterionLine('المحافظة على العقار', tc.propertyCare),
                          _criterionLine('التعاون', tc.cooperation),
                          _criterionLine('الالتزام بالعقد', tc.contractCompliance),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
