import 'package:flutter/material.dart';
import 'package:ejari/app_session.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/state/ratings_notifier.dart';
import 'package:ejari/theme/app_theme.dart';
import 'package:ejari/utils/format_date_ar.dart';
import 'package:ejari/widgets/public_profile_nav.dart';
import 'package:ejari/widgets/report_review_dialog.dart';

class MyRatingsScreen extends StatelessWidget {
  const MyRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListenableBuilder(
        listenable: Listenable.merge([ejariSession, ratingsNotifier]),
        builder: (context, _) {
          final u = ejariSession.user;
          if (u == null || ejariSession.isGuest) {
            return Scaffold(
              appBar: AppBar(title: const Text('سجل تقييماتي')),
              body: const Center(child: Text('سجّل الدخول لعرض تقييماتك.')),
            );
          }
          final summary = ratingsNotifier.summaryForUser(userId: u.id, role: u.role);
          if (summary == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('سجل تقييماتي')),
              body: const Center(child: Text('لا يتوفر سجل لنوع حسابك.')),
            );
          }
          return Scaffold(
            backgroundColor: EjariColors.background,
            appBar: AppBar(
              title: const Text('سجل تقييماتي'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                _SummaryHeader(summary: summary),
                const SizedBox(height: 20),
                Text(
                  'توزيع النجوم',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                _StarDistributionChart(dist: summary.starDistribution),
                const SizedBox(height: 20),
                Text(
                  'جميع التقييمات',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                if (summary.entries.isEmpty)
                  Text(
                    'لا توجد تقييمات بعد.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EjariColors.textSecondary),
                  )
                else
                  ...summary.entries.map((e) => _ReceivedRatingEntryTile(entry: e)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.summary});

  final UserRatingSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EjariColors.secondary.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'متوسط التقييم العام',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EjariColors.textSecondary),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                summary.averageRating > 0 ? summary.averageRating.toStringAsFixed(1) : '—',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: EjariColors.primary,
                    ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.star_rounded, color: EjariColors.starFilled, size: 32),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarDistributionChart extends StatelessWidget {
  const _StarDistributionChart({required this.dist});

  final Map<int, int> dist;

  @override
  Widget build(BuildContext context) {
    final counts = List<int>.generate(5, (i) => dist[i + 1] ?? 0);
    final max = counts.fold<int>(0, (a, b) => a > b ? a : b);
    final denom = max == 0 ? 1 : max;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EjariColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: List.generate(5, (i) {
          final stars = 5 - i;
          final count = counts[stars - 1];
          final w = count / denom;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text('$count', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: w.clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: EjariColors.lavenderMuted,
                      color: EjariColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('$stars', style: const TextStyle(fontWeight: FontWeight.w700)),
                      const Icon(Icons.star_rounded, size: 14, color: EjariColors.starFilled),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ReceivedRatingEntryTile extends StatelessWidget {
  const _ReceivedRatingEntryTile({required this.entry});

  final UserReceivedRatingEntry entry;

  @override
  Widget build(BuildContext context) {
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
            if (entry.landlordCriteria != null) ...[
              const SizedBox(height: 8),
              _criteriaBlock(
                context,
                'معايير تقييمك كمالك',
                [
                  ('التعاون والتواصل', entry.landlordCriteria!.cooperation),
                  ('صيانة العقار', entry.landlordCriteria!.maintenance),
                  ('الاستجابة للطلبات', entry.landlordCriteria!.responsiveness),
                  ('الشفافية', entry.landlordCriteria!.transparency),
                ],
              ),
            ],
            if (entry.tenantCriteria != null) ...[
              const SizedBox(height: 8),
              _criteriaBlock(
                context,
                'معايير تقييمك كمستأجر',
                [
                  ('الالتزام بالدفع', entry.tenantCriteria!.paymentTimeliness),
                  ('المحافظة على العقار', entry.tenantCriteria!.propertyCare),
                  ('التعاون', entry.tenantCriteria!.cooperation),
                  ('الالتزام بالعقد', entry.tenantCriteria!.contractCompliance),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Widget _criteriaBlock(
    BuildContext context,
    String title,
    List<(String, int)> pairs,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          ...pairs.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${p.$2}/5', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Text(p.$1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
