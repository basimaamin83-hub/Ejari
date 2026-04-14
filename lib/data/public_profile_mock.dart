import 'package:ejari/models/rating_models.dart';

/// تقييمات وهمية تُعرض في الملف العام للمكاتب (لا تُخزَّن في [RatingsNotifier]).
UserRatingSummary officeRatingSummaryFor(String officeUserId) {
  final raw = kOfficeReceivedReviews[officeUserId] ?? const [];
  if (raw.isEmpty) return emptyUserRatingSummary;
  final dist = <int, int>{for (var i = 1; i <= 5; i++) i: 0};
  for (final e in raw) {
    dist[e.overallStars] = (dist[e.overallStars] ?? 0) + 1;
  }
  final avg = raw.fold<double>(0, (s, e) => s + e.overallStars) / raw.length;
  return UserRatingSummary(
    averageRating: avg,
    starDistribution: dist,
    entries: raw,
  );
}

final Map<String, List<UserReceivedRatingEntry>> kOfficeReceivedReviews = {
  'u-office-1': [
    UserReceivedRatingEntry(
      id: 'or-1',
      reviewedAt: DateTime(2025, 12, 1),
      overallStars: 5,
      reviewerName: 'ليث المصري',
      comment: 'تعامل احترافي وتنسيق ممتاز بين المالك والمستأجر.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 5,
        maintenance: 4,
        responsiveness: 5,
        transparency: 5,
      ),
      reviewerUserId: 'u-tenant-2',
    ),
    UserReceivedRatingEntry(
      id: 'or-2',
      reviewedAt: DateTime(2025, 9, 20),
      overallStars: 4,
      reviewerName: 'نورا الزعبي',
      comment: 'خدمة جيدة، تأخر بسيط في الرد مرة واحدة.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 4,
        maintenance: 4,
        responsiveness: 3,
        transparency: 4,
      ),
      reviewerUserId: 'u-tenant-3',
    ),
    UserReceivedRatingEntry(
      id: 'or-3',
      reviewedAt: DateTime(2025, 6, 5),
      overallStars: 5,
      reviewerName: 'أحمد الأحمد',
      comment: 'أنصح بالتعامل مع المكتب.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 5,
        maintenance: 5,
        responsiveness: 5,
        transparency: 5,
      ),
      reviewerUserId: 'u-tenant-1',
    ),
    UserReceivedRatingEntry(
      id: 'or-4',
      reviewedAt: DateTime(2024, 11, 11),
      overallStars: 4,
      reviewerName: 'خالد نعيرات',
      comment: null,
      landlordCriteria: const LandlordCriteria(
        cooperation: 4,
        maintenance: 4,
        responsiveness: 4,
        transparency: 4,
      ),
      reviewerUserId: 'u-tenant-3',
    ),
  ],
  'u-office-2': [
    UserReceivedRatingEntry(
      id: 'or2-1',
      reviewedAt: DateTime(2025, 10, 15),
      overallStars: 5,
      reviewerName: 'سارة فتحي',
      comment: 'فريق متعاون وواضح في العمولات.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 5,
        maintenance: 5,
        responsiveness: 5,
        transparency: 5,
      ),
      reviewerUserId: 'u-tenant-2',
    ),
    UserReceivedRatingEntry(
      id: 'or2-2',
      reviewedAt: DateTime(2025, 4, 2),
      overallStars: 4,
      reviewerName: 'أحمد الأحمد',
      comment: 'تجربة إيجابية بشكل عام.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 4,
        maintenance: 4,
        responsiveness: 4,
        transparency: 5,
      ),
      reviewerUserId: 'u-tenant-1',
    ),
    UserReceivedRatingEntry(
      id: 'or2-3',
      reviewedAt: DateTime(2024, 8, 30),
      overallStars: 3,
      reviewerName: 'عمر النابلسي',
      comment: 'أتمنى سرعة أكبر في المتابعة.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 3,
        maintenance: 3,
        responsiveness: 3,
        transparency: 4,
      ),
      reviewerUserId: 'u-owner-3',
    ),
  ],
  'u-office-3': [
    UserReceivedRatingEntry(
      id: 'or3-1',
      reviewedAt: DateTime(2025, 11, 22),
      overallStars: 5,
      reviewerName: 'محمد الأحمد',
      comment: 'مستشارون ملمّون بالسوق.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 5,
        maintenance: 4,
        responsiveness: 5,
        transparency: 5,
      ),
      reviewerUserId: 'u-owner-1',
    ),
    UserReceivedRatingEntry(
      id: 'or3-2',
      reviewedAt: DateTime(2025, 7, 8),
      overallStars: 4,
      reviewerName: 'سارة الخالدي',
      comment: null,
      landlordCriteria: const LandlordCriteria(
        cooperation: 4,
        maintenance: 4,
        responsiveness: 4,
        transparency: 4,
      ),
      reviewerUserId: 'u-owner-2',
    ),
    UserReceivedRatingEntry(
      id: 'or3-3',
      reviewedAt: DateTime(2024, 12, 18),
      overallStars: 5,
      reviewerName: 'خالد نعيرات',
      comment: 'شفافية عالية في العقود.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 5,
        maintenance: 5,
        responsiveness: 5,
        transparency: 5,
      ),
      reviewerUserId: 'u-tenant-3',
    ),
    UserReceivedRatingEntry(
      id: 'or3-4',
      reviewedAt: DateTime(2024, 3, 3),
      overallStars: 4,
      reviewerName: 'أحمد الأحمد',
      comment: 'خدمة ممتازة.',
      landlordCriteria: const LandlordCriteria(
        cooperation: 4,
        maintenance: 4,
        responsiveness: 5,
        transparency: 4,
      ),
      reviewerUserId: 'u-tenant-1',
    ),
  ],
};
