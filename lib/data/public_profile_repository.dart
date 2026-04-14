import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/data/public_profile_mock.dart';
import 'package:ejari/data/ratings_mock_data.dart';
import 'package:ejari/models/public_profile_model.dart';
import 'package:ejari/models/rating_models.dart' show UserRatingSummary, emptyUserRatingSummary;
import 'package:ejari/models/user_model.dart';
import 'package:ejari/state/ratings_notifier.dart';

Future<PublicProfileData?> loadPublicProfile(String userId) async {
  await Future<void>.delayed(Duration.zero);
  final user = userById(userId);
  if (user == null) return null;

  final UserRatingSummary summary = _ratingSummaryFor(user);
  final reviewCount = summary.entries.length;

  OwnerPublicExtras? owner;
  TenantPublicExtras? tenant;
  AgencyPublicExtras? agency;

  if (user.role == 'owner') {
    final owned = mockProperties.where((p) => p.ownerId == user.id).toList();
    final reviews = ratingsNotifier.landlordReviewsForOwner(user.id);
    double avgMaint = 0;
    if (reviews.isNotEmpty) {
      avgMaint = reviews.fold<double>(0, (s, r) => s + r.criteria.maintenance) / reviews.length;
    }
    owner = OwnerPublicExtras(
      ownedPropertyCount: owned.length,
      properties: owned.map((p) => (title: p.title, rooms: p.rooms)).toList(),
      avgMaintenanceFromReviews: avgMaint,
    );
  } else if (user.role == 'tenant') {
    tenant = TenantPublicExtras(
      pastContractsCount: kMockTenantPastContracts[user.id] ?? 0,
      paymentCompliancePercent: kMockTenantPaymentPercent[user.id] ?? 0,
      complaintsCount: kMockTenantComplaints[user.id] ?? 0,
    );
  } else if (user.role == 'office' || user.userType == 'agency') {
    final aid = user.agencyId;
    if (aid != null) {
      final profile = agencyProfileFor(aid);
      final props = agencyProperties(aid);
      final contracts = agencyContractsFor(aid);
      final comms = agencyCommissionsFor(aid);
      double avgComm = profile.defaultCommissionPercent;
      if (comms.isNotEmpty) {
        avgComm = comms.fold<double>(0, (s, c) => s + c.commissionPercent) / comms.length;
      }
      agency = AgencyPublicExtras(
        licenseNumber: profile.licenseNumber,
        managedPropertiesCount: props.length,
        completedContractsCount: contracts.length,
        averageCommissionPercent: avgComm,
      );
    }
  }

  return PublicProfileData(
    user: user,
    ratingSummary: summary,
    reviewCount: reviewCount,
    owner: owner,
    tenant: tenant,
    agency: agency,
  );
}

UserRatingSummary _ratingSummaryFor(UserModel user) {
  if (user.role == 'tenant') {
    return ratingsNotifier.summaryForUser(userId: user.id, role: 'tenant') ?? emptyUserRatingSummary;
  }
  if (user.role == 'owner') {
    return ratingsNotifier.summaryForUser(userId: user.id, role: 'owner') ?? emptyUserRatingSummary;
  }
  if (user.role == 'office' || user.userType == 'agency') {
    return officeRatingSummaryFor(user.id);
  }
  return emptyUserRatingSummary;
}
