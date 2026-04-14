import 'package:flutter/foundation.dart';

/// نماذج التقييم: [LandlordReview] (المستأجر → المالك) و [TenantReview] (المالك → المستأجر)،
/// مع [UserRatingSummary] لشاشة «سجل تقييماتي».

/// معايير تقييم المالك (من المستأجر).
@immutable
class LandlordCriteria {
  const LandlordCriteria({
    required this.cooperation,
    required this.maintenance,
    required this.responsiveness,
    required this.transparency,
  });

  final int cooperation;
  final int maintenance;
  final int responsiveness;
  final int transparency;

  double get average =>
      (cooperation + maintenance + responsiveness + transparency) / 4.0;

  int get overallStars => average.round().clamp(1, 5);

  /// عرض مختصر للمعايير (مثال: 4, 5, 4, 4).
  String get summaryNumbers =>
      '$cooperation, $maintenance, $responsiveness, $transparency';
}

/// معايير تقييم المستأجر (من المالك).
@immutable
class TenantCriteria {
  const TenantCriteria({
    required this.paymentTimeliness,
    required this.propertyCare,
    required this.cooperation,
    required this.contractCompliance,
  });

  final int paymentTimeliness;
  final int propertyCare;
  final int cooperation;
  final int contractCompliance;

  double get average =>
      (paymentTimeliness + propertyCare + cooperation + contractCompliance) / 4.0;

  int get overallStars => average.round().clamp(1, 5);

  /// عرض مختصر للمعايير (مثال: 5, 4, 5, 5).
  String get summaryNumbers =>
      '$paymentTimeliness, $propertyCare, $cooperation, $contractCompliance';
}

/// ترتيب قائمة تقييمات المالك (الشاشة الكاملة).
enum LandlordReviewSort { newest, highestRating, lowestRating }

/// تقييم أداء المالك من قبل مستأجر (مرتبط بعقد).
@immutable
class LandlordReview {
  const LandlordReview({
    required this.id,
    required this.contractId,
    required this.landlordId,
    required this.tenantId,
    required this.tenantDisplayName,
    required this.hideTenantName,
    required this.reviewedAt,
    required this.criteria,
    this.comment,
  });

  final String id;
  final String contractId;
  final String landlordId;
  final String tenantId;
  final String tenantDisplayName;
  final bool hideTenantName;
  final DateTime reviewedAt;
  final LandlordCriteria criteria;
  final String? comment;

  String get reviewerVisibleName =>
      hideTenantName ? 'مستخدم محظوظ' : tenantDisplayName;

  double get overallAverage => criteria.average;
  int get overallStars => criteria.overallStars;
}

/// تقييم أداء المستأجر من قبل مالك (مرتبط بعقد).
@immutable
class TenantReview {
  const TenantReview({
    required this.id,
    required this.contractId,
    required this.landlordId,
    required this.tenantId,
    required this.landlordDisplayName,
    required this.reviewedAt,
    required this.criteria,
    this.comment,
  });

  final String id;
  final String contractId;
  final String landlordId;
  final String tenantId;
  final String landlordDisplayName;
  final DateTime reviewedAt;
  final TenantCriteria criteria;
  final String? comment;

  double get overallAverage => criteria.average;
  int get overallStars => criteria.overallStars;
}

/// ملخص سمعة المستأجر (لعرض المالك عند طلب الإيجار).
@immutable
class TenantReputationSnapshot {
  const TenantReputationSnapshot({
    required this.tenantId,
    required this.averageRating,
    required this.paymentCompliancePercent,
    required this.pastContractsCount,
    required this.complaintsCount,
    this.violationsNote,
    required this.lastReviews,
  });

  final String tenantId;
  final double averageRating;
  final int paymentCompliancePercent;
  final int pastContractsCount;
  final int complaintsCount;
  final String? violationsNote;
  final List<TenantReview> lastReviews;
}

/// ملخص تقييمات استلمها مستخدم (شاشة «سجل تقييماتي»).
@immutable
class UserRatingSummary {
  UserRatingSummary({
    required this.averageRating,
    required Map<int, int> starDistribution,
    required this.entries,
  }) : starDistribution = Map<int, int>.unmodifiable(starDistribution);

  final double averageRating;
  /// عدد التقييمات لكل مستوى نجوم (1..5).
  final Map<int, int> starDistribution;
  final List<UserReceivedRatingEntry> entries;
}

UserRatingSummary get emptyUserRatingSummary => UserRatingSummary(
      averageRating: 0,
      starDistribution: const {},
      entries: const [],
    );

@immutable
class UserReceivedRatingEntry {
  const UserReceivedRatingEntry({
    required this.id,
    required this.reviewedAt,
    required this.overallStars,
    required this.reviewerName,
    this.comment,
    this.landlordCriteria,
    this.tenantCriteria,
    this.reviewerUserId,
  });

  final String id;
  final DateTime reviewedAt;
  final int overallStars;
  final String reviewerName;
  final String? comment;
  final LandlordCriteria? landlordCriteria;
  final TenantCriteria? tenantCriteria;
  /// معرف المقيم في بيانات المستخدمين الوهمية (للملف العام).
  final String? reviewerUserId;
}
