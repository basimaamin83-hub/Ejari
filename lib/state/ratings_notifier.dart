import 'package:flutter/foundation.dart';
import 'package:ejari/data/ratings_mock_data.dart';
import 'package:ejari/models/rating_models.dart' show
    LandlordReview,
    LandlordReviewSort,
    TenantReputationSnapshot,
    TenantReview,
    UserRatingSummary,
    UserReceivedRatingEntry,
    emptyUserRatingSummary;

final ratingsNotifier = RatingsNotifier();

/// يدمج البيانات الوهمية مع التقييمات المضافة أثناء الجلسة.
class RatingsNotifier extends ChangeNotifier {
  RatingsNotifier() {
    _landlord.addAll(seedLandlordReviews);
    _tenant.addAll(seedTenantReviews);
  }

  final List<LandlordReview> _landlord = [];
  final List<TenantReview> _tenant = [];

  List<LandlordReview> landlordReviewsForOwner(String ownerId) {
    final list = _landlord.where((r) => r.landlordId == ownerId).toList();
    list.sort((a, b) => b.reviewedAt.compareTo(a.reviewedAt));
    return list;
  }

  List<LandlordReview> lastLandlordReviews(String ownerId, {int limit = 10}) {
    final all = landlordReviewsForOwner(ownerId);
    return all.length <= limit ? all : all.sublist(0, limit);
  }

  double averageLandlordRating(String ownerId) {
    final list = _landlord.where((r) => r.landlordId == ownerId).toList();
    if (list.isEmpty) return 0;
    final sum = list.fold<double>(0, (s, r) => s + r.overallAverage);
    return sum / list.length;
  }

  /// تقييمات المستأجر من **مالكين آخرين** (يُستبعد المالك الحالي).
  List<TenantReview> tenantReviewsFromOtherLandlords(
    String tenantId,
    String excludeLandlordId,
  ) {
    final list = _tenant
        .where((r) => r.tenantId == tenantId && r.landlordId != excludeLandlordId)
        .toList();
    list.sort((a, b) => b.reviewedAt.compareTo(a.reviewedAt));
    return list;
  }

  /// تقييمات المالك من **مستأجرين آخرين** (يُستبعد المستأجر الحالي).
  List<LandlordReview> landlordReviewsFromOtherTenants(
    String landlordId,
    String excludeTenantId,
  ) {
    final list = _landlord
        .where((r) => r.landlordId == landlordId && r.tenantId != excludeTenantId)
        .toList();
    list.sort((a, b) => b.reviewedAt.compareTo(a.reviewedAt));
    return list;
  }

  List<LandlordReview> landlordReviewsFiltered(
    String ownerId,
    LandlordReviewSort sort,
  ) {
    final list = landlordReviewsForOwner(ownerId);
    switch (sort) {
      case LandlordReviewSort.newest:
        return list;
      case LandlordReviewSort.highestRating:
        list.sort((a, b) => b.overallAverage.compareTo(a.overallAverage));
        return list;
      case LandlordReviewSort.lowestRating:
        list.sort((a, b) => a.overallAverage.compareTo(b.overallAverage));
        return list;
    }
  }

  TenantReputationSnapshot tenantSnapshot(String tenantId) {
    final mine = _tenant.where((r) => r.tenantId == tenantId).toList();
    mine.sort((a, b) => b.reviewedAt.compareTo(a.reviewedAt));
    final avg = mine.isEmpty
        ? 0.0
        : mine.fold<double>(0, (s, r) => s + r.overallAverage) / mine.length;
    final last5 = mine.length <= 5 ? mine : mine.sublist(0, 5);
    return TenantReputationSnapshot(
      tenantId: tenantId,
      averageRating: avg,
      paymentCompliancePercent: kMockTenantPaymentPercent[tenantId] ?? 80,
      pastContractsCount: kMockTenantPastContracts[tenantId] ?? 0,
      complaintsCount: kMockTenantComplaints[tenantId] ?? 0,
      violationsNote: kMockTenantViolations[tenantId],
      lastReviews: last5,
    );
  }

  UserRatingSummary? summaryForUser({required String userId, required String role}) {
    if (role == 'tenant') {
      final mine = _tenant.where((r) => r.tenantId == userId).toList();
      mine.sort((a, b) => b.reviewedAt.compareTo(a.reviewedAt));
      return _buildSummaryFromTenantReviews(mine);
    }
    if (role == 'owner') {
      final mine = _landlord.where((r) => r.landlordId == userId).toList();
      mine.sort((a, b) => b.reviewedAt.compareTo(a.reviewedAt));
      return _buildSummaryFromLandlordReviews(mine);
    }
    return null;
  }

  UserRatingSummary _buildSummaryFromLandlordReviews(List<LandlordReview> mine) {
    if (mine.isEmpty) {
      return emptyUserRatingSummary;
    }
    final dist = <int, int>{for (var i = 1; i <= 5; i++) i: 0};
    for (final r in mine) {
      final s = r.overallStars;
      dist[s] = (dist[s] ?? 0) + 1;
    }
    final avg = mine.fold<double>(0, (s, r) => s + r.overallAverage) / mine.length;
    final entries = mine.map((r) {
      return UserReceivedRatingEntry(
        id: r.id,
        reviewedAt: r.reviewedAt,
        overallStars: r.overallStars,
        reviewerName: r.reviewerVisibleName,
        comment: r.comment,
        landlordCriteria: r.criteria,
        tenantCriteria: null,
        reviewerUserId: r.tenantId,
      );
    }).toList();
    return UserRatingSummary(
      averageRating: avg,
      starDistribution: dist,
      entries: entries,
    );
  }

  UserRatingSummary _buildSummaryFromTenantReviews(List<TenantReview> mine) {
    if (mine.isEmpty) {
      return emptyUserRatingSummary;
    }
    final dist = <int, int>{for (var i = 1; i <= 5; i++) i: 0};
    for (final r in mine) {
      final s = r.overallStars;
      dist[s] = (dist[s] ?? 0) + 1;
    }
    final avg = mine.fold<double>(0, (s, r) => s + r.overallAverage) / mine.length;
    final entries = mine.map((r) {
      return UserReceivedRatingEntry(
        id: r.id,
        reviewedAt: r.reviewedAt,
        overallStars: r.overallStars,
        reviewerName: r.landlordDisplayName,
        comment: r.comment,
        landlordCriteria: null,
        tenantCriteria: r.criteria,
        reviewerUserId: r.landlordId,
      );
    }).toList();
    return UserRatingSummary(
      averageRating: avg,
      starDistribution: dist,
      entries: entries,
    );
  }

  /// تقييم المالك من هذا المستأجر على هذا العقد (مرة واحدة).
  bool tenantHasRatedLandlord({
    required String contractId,
    required String tenantId,
  }) =>
      _landlord.any((r) => r.contractId == contractId && r.tenantId == tenantId);

  /// تقييم المستأجر من هذا المالك على هذا العقد (مرة واحدة).
  bool landlordHasRatedTenant({
    required String contractId,
    required String landlordId,
  }) =>
      _tenant.any((r) => r.contractId == contractId && r.landlordId == landlordId);

  void submitLandlordReview(LandlordReview review) {
    _landlord.add(review);
    notifyListeners();
  }

  void submitTenantReview(TenantReview review) {
    _tenant.add(review);
    notifyListeners();
  }

  void resetSession() {
    notifyListeners();
  }
}
