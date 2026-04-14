import 'package:ejari/models/agency_models.dart';

class PropertyModel {
  const PropertyModel({
    required this.id,
    required this.title,
    required this.governorate,
    required this.district,
    required this.location,
    required this.rooms,
    required this.bathrooms,
    required this.areaSqm,
    required this.priceMonthly,
    required this.ownerName,
    required this.ownerRating,
    this.reviewCount = 0,
    this.rating = 0,
    this.tags = const [],
    this.availableNow = true,
    this.description = '',
    this.imageSeeds = const [],
    this.ownerListedPropertiesCount = 3,
    this.ownerPhone = '+962790000000',
    required this.ownerId,
    /// المكتب العقاري المكلّف بالعقار (إن وُجد).
    this.agencyId,
    /// نسبة عمولة المكتب لهذا العقار (٪) — اختياري.
    this.commissionRate,
    /// طلبات صيانة مرتبطة بالعقار (وهمي / من المكتب).
    this.maintenanceRequests = const [],
  });

  final String id;
  /// معرف المالك في النظام (للتقييمات والعقود).
  final String ownerId;
  final String? agencyId;
  final double? commissionRate;
  final List<AgencyMaintenanceRequestModel> maintenanceRequests;
  final String title;
  final String governorate;
  /// المنطقة ضمن المحافظة (للتصفية مع القائمة المنسدلة).
  final String district;
  final String location;
  final int rooms;
  final int bathrooms;
  final int areaSqm;
  final double priceMonthly;
  final String ownerName;
  final double ownerRating;
  final int reviewCount;
  final double rating;
  final List<String> tags;
  final bool availableNow;
  final String description;
  /// مفاتيح صور ثابتة تُربط بروابط Unsplash/أصول في [ejariPlaceholderImage].
  final List<String> imageSeeds;

  /// عدد عقارات المالك المعروضة في المنصة (وهمي).
  final int ownerListedPropertiesCount;

  /// هاتف المالك لاتصال / واتساب (وهمي).
  final String ownerPhone;

  String? get primaryImageSeed => imageSeeds.isEmpty ? null : imageSeeds.first;
}
