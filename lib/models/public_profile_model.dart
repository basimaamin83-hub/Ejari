import 'package:flutter/foundation.dart';
import 'package:ejari/models/rating_models.dart';
import 'package:ejari/models/user_model.dart';

/// بيانات مجمّعة لشاشة الملف العام.
@immutable
class PublicProfileData {
  const PublicProfileData({
    required this.user,
    required this.ratingSummary,
    required this.reviewCount,
    this.owner,
    this.tenant,
    this.agency,
  });

  final UserModel user;
  final UserRatingSummary ratingSummary;
  final int reviewCount;
  final OwnerPublicExtras? owner;
  final TenantPublicExtras? tenant;
  final AgencyPublicExtras? agency;
}

@immutable
class OwnerPublicExtras {
  const OwnerPublicExtras({
    required this.ownedPropertyCount,
    required this.properties,
    required this.avgMaintenanceFromReviews,
  });

  final int ownedPropertyCount;
  final List<({String title, int rooms})> properties;
  /// متوسط درجة «صيانة العقار» من تقييمات المستأجرين.
  final double avgMaintenanceFromReviews;
}

@immutable
class TenantPublicExtras {
  const TenantPublicExtras({
    required this.pastContractsCount,
    required this.paymentCompliancePercent,
    required this.complaintsCount,
  });

  final int pastContractsCount;
  final int paymentCompliancePercent;
  final int complaintsCount;
}

@immutable
class AgencyPublicExtras {
  const AgencyPublicExtras({
    required this.licenseNumber,
    required this.managedPropertiesCount,
    required this.completedContractsCount,
    required this.averageCommissionPercent,
  });

  final String licenseNumber;
  final int managedPropertiesCount;
  final int completedContractsCount;
  final double averageCommissionPercent;
}
