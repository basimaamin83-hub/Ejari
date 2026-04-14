import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/data/jordan_locations.dart';
import 'package:ejari/models/contract_model.dart';
import 'package:ejari/models/property_model.dart';
import 'package:ejari/models/property_review_model.dart';
import 'package:ejari/models/user_model.dart';

final UserModel mockTenantUser = UserModel(
  id: 'u-tenant-1',
  fullName: 'أحمد الأحمد',
  role: 'tenant',
  idNumber: '9851234567',
  phone: '+962 79 123 4567',
  email: 'ahmad@gmail.com',
  registeredAt: DateTime(2024, 1, 1),
  isVerified: true,
);

final UserModel mockOwnerUser = UserModel(
  id: 'u-owner-1',
  fullName: 'محمد الأحمد',
  role: 'owner',
  idNumber: '9840000001',
  phone: '+962 79 111 2233',
  email: 'owner@example.jo',
  registeredAt: DateTime(2023, 6, 1),
  isVerified: true,
);

final UserModel mockOfficeUser = UserModel(
  id: 'u-office-1',
  fullName: 'مكتب الأردن العقاري',
  role: 'office',
  idNumber: null,
  phone: '+962 6 555 0101',
  email: 'info@office.jo',
  registeredAt: DateTime(2022, 1, 10),
  isVerified: true,
  userType: 'agency',
  agencyId: kAgency1Id,
  defaultCommissionRate: 2.5,
);

final UserModel mockOfficeUser2 = UserModel(
  id: 'u-office-2',
  fullName: 'فريق السكن المثالي',
  role: 'office',
  phone: '+962 6 777 8899',
  email: 'team@alsakan.jo',
  registeredAt: DateTime(2021, 5, 1),
  isVerified: true,
  userType: 'agency',
  agencyId: kAgency2Id,
  defaultCommissionRate: 3.0,
);

final UserModel mockOfficeUser3 = UserModel(
  id: 'u-office-3',
  fullName: 'مستشارو بيوت الأردن',
  role: 'office',
  phone: '+962 6 555 0102',
  email: 'advisors@byut-jo.jo',
  registeredAt: DateTime(2023, 3, 15),
  isVerified: true,
  userType: 'agency',
  agencyId: kAgency1Id,
  defaultCommissionRate: 2.5,
);

final UserModel mockTenant2 = UserModel(
  id: 'u-tenant-2',
  fullName: 'سارة فتحي',
  role: 'tenant',
  phone: '+962 79 222 3344',
  email: 'sara.f@mail.jo',
  registeredAt: DateTime(2024, 3, 1),
  isVerified: true,
);

final UserModel mockTenant3 = UserModel(
  id: 'u-tenant-3',
  fullName: 'خالد نعيرات',
  role: 'tenant',
  phone: '+962 78 333 4455',
  email: 'khaled.n@mail.jo',
  registeredAt: DateTime(2023, 11, 5),
  isVerified: true,
);

final UserModel mockOwner2 = UserModel(
  id: 'u-owner-2',
  fullName: 'سارة الخالدي',
  role: 'owner',
  phone: '+962 79 444 5566',
  email: 'sara.k@mail.jo',
  registeredAt: DateTime(2023, 2, 1),
  isVerified: true,
);

final UserModel mockOwner3 = UserModel(
  id: 'u-owner-3',
  fullName: 'عمر النابلسي',
  role: 'owner',
  phone: '+962 79 555 6677',
  email: 'omar.n@mail.jo',
  registeredAt: DateTime(2022, 8, 20),
  isVerified: true,
);

const List<String> governorates = [
  'الكل',
  ...selectableGovernorates,
];

final List<PropertyModel> mockProperties = [
  PropertyModel(
    id: 'p-1',
    title: 'شقة مفروشة - الصويفية',
    governorate: 'عمان',
    district: 'الصويفية',
    location: 'الصويفية - عمان',
    rooms: 2,
    bathrooms: 1,
    areaSqm: 120,
    priceMonthly: 350,
    ownerName: 'محمد الأحمد',
    ownerRating: 4.9,
    rating: 4.8,
    reviewCount: 24,
    tags: ['مفروشة', 'موقف سيارة', 'مصعد'],
    description:
        'شقة حديثة قريبة من الخدمات، مفروشة بالكامل، مناسبة لعائلة صغيرة.',
    imageSeeds: ['ejari-living-1', 'ejari-bed-1', 'ejari-kitchen-1'],
    ownerListedPropertiesCount: 6,
    ownerPhone: '+962791112233',
    ownerId: 'u-owner-1',
  ),
  PropertyModel(
    id: 'p-2',
    title: 'شقة - الشميساني',
    governorate: 'عمان',
    district: 'الشميساني',
    location: 'الشميساني - عمان',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 140,
    priceMonthly: 420,
    ownerName: 'سارة الخالدي',
    ownerRating: 4.7,
    rating: 4.6,
    reviewCount: 11,
    tags: ['تكييف مركزي', 'موقف'],
    imageSeeds: ['ejari-living-2'],
    ownerId: 'u-owner-2',
  ),
  PropertyModel(
    id: 'p-3',
    title: 'استوديو - إربد',
    governorate: 'إربد',
    district: 'الحصن',
    location: 'الحصن - إربد',
    rooms: 1,
    bathrooms: 1,
    areaSqm: 45,
    priceMonthly: 180,
    ownerName: 'عمر النابلسي',
    ownerRating: 4.5,
    rating: 4.4,
    reviewCount: 8,
    tags: ['مفروشة'],
    imageSeeds: ['ejari-studio-1'],
    ownerId: 'u-owner-3',
  ),
  PropertyModel(
    id: 'p-4',
    title: 'بيت مستقل - الزرقاء',
    governorate: 'الزرقاء',
    district: 'الزرقاء الجديدة',
    location: 'الزرقاء الجديدة',
    rooms: 4,
    bathrooms: 2,
    areaSqm: 190,
    priceMonthly: 280,
    ownerName: 'خالد العبادي',
    ownerRating: 4.8,
    rating: 4.9,
    reviewCount: 6,
    tags: ['حديقة', 'موقف سيارتين'],
    imageSeeds: ['ejari-house-1'],
    ownerId: 'u-owner-1',
  ),
  PropertyModel(
    id: 'p-5',
    title: 'شقة - الجبيهة',
    governorate: 'عمان',
    district: 'الجبيهة',
    location: 'الجبيهة - عمان',
    rooms: 2,
    bathrooms: 2,
    areaSqm: 110,
    priceMonthly: 310,
    ownerName: 'لينا التل',
    ownerRating: 4.6,
    rating: 4.5,
    reviewCount: 15,
    tags: ['مصعد', 'أمن 24/7'],
    imageSeeds: ['ejari-apt-5'],
    ownerId: 'u-owner-2',
  ),
  PropertyModel(
    id: 'p-6',
    title: 'شقة - ماركا',
    governorate: 'عمان',
    district: 'ماركا',
    location: 'ماركا الشمالية - عمان',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 135,
    priceMonthly: 360,
    ownerName: 'باسل الهاشم',
    ownerRating: 4.4,
    rating: 4.3,
    reviewCount: 9,
    tags: ['بلكونة واسعة'],
    imageSeeds: ['ejari-apt-6'],
    ownerId: 'u-owner-3',
  ),
  PropertyModel(
    id: 'p-7',
    title: 'شقة دوبلكس - العقبة',
    governorate: 'العقبة',
    district: 'الحي السياحي',
    location: 'الحي السياحي - العقبة',
    rooms: 3,
    bathrooms: 3,
    areaSqm: 160,
    priceMonthly: 450,
    ownerName: 'ريم العوضي',
    ownerRating: 4.9,
    rating: 4.8,
    reviewCount: 20,
    tags: ['إطلالة بحر', 'مسبح مشترك'],
    imageSeeds: ['ejari-aqaba-1'],
    ownerId: 'u-owner-1',
  ),
  PropertyModel(
    id: 'p-8',
    title: 'شقة - جرش',
    governorate: 'جرش',
    district: 'وسط المدينة',
    location: 'وسط المدينة - جرش',
    rooms: 2,
    bathrooms: 1,
    areaSqm: 95,
    priceMonthly: 220,
    ownerName: 'نادر الشوا',
    ownerRating: 4.5,
    rating: 4.5,
    reviewCount: 5,
    tags: ['قريبة من الأثار'],
    imageSeeds: ['ejari-jerash-1'],
    ownerId: 'u-owner-2',
  ),
  PropertyModel(
    id: 'p-9',
    title: 'شقة فاخرة - عبدون',
    governorate: 'عمان',
    district: 'عبدون',
    location: 'عبدون - عمان',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 155,
    priceMonthly: 480,
    ownerName: 'هالة أبو زيتون',
    ownerRating: 4.8,
    rating: 4.7,
    reviewCount: 18,
    tags: ['مفروشة جزئياً', 'موقف مزدوج'],
    description: 'شقة واسعة قرب الخدمات، تشطيبات عالية.',
    imageSeeds: ['ejari-abdoun-1', 'ejari-kitchen-1'],
    ownerId: 'u-owner-3',
  ),
  PropertyModel(
    id: 'p-10',
    title: 'شقة عائلية - خلدا',
    governorate: 'عمان',
    district: 'خلدا',
    location: 'خلدا - عمان',
    rooms: 4,
    bathrooms: 3,
    areaSqm: 175,
    priceMonthly: 440,
    ownerName: 'وائل الخطيب',
    ownerRating: 4.6,
    rating: 4.6,
    reviewCount: 12,
    tags: ['غير مفروشة', 'مصعد', 'أمن'],
    imageSeeds: ['ejari-khalda-1', 'ejari-living-1'],
    ownerId: 'u-owner-1',
  ),
  PropertyModel(
    id: 'p-11',
    title: 'شقة - طبربور',
    governorate: 'عمان',
    district: 'طبربور',
    location: 'طبربور - عمان',
    rooms: 2,
    bathrooms: 1,
    areaSqm: 98,
    priceMonthly: 265,
    ownerName: 'نبيل القضاة',
    ownerRating: 4.5,
    rating: 4.4,
    reviewCount: 7,
    tags: ['شرفة', 'مدخل مستقل'],
    imageSeeds: ['ejari-tabbabor-1'],
    ownerId: 'u-owner-2',
  ),
  PropertyModel(
    id: 'p-12',
    title: 'شقة أرضية - ناعور',
    governorate: 'عمان',
    district: 'ناعور',
    location: 'ناعور - عمان',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 130,
    priceMonthly: 290,
    ownerName: 'ماجد السعود',
    ownerRating: 4.7,
    rating: 4.5,
    reviewCount: 10,
    tags: ['حديقة صغيرة', 'موقف'],
    imageSeeds: ['ejari-naour-1', 'ejari-bed-1'],
    ownerId: 'u-owner-3',
  ),
];

ContractModel mockActiveContractForTenant(String tenantId) {
  final leaseStart = DateTime(2026, 6, 1);
  final leaseEnd = DateTime(2027, 6, 1);
  final daysLeft = leaseEnd.difference(DateTime.now()).inDays;
  final prop = propertyById('p-1');
  return ContractModel(
    id: 'c-1',
    tenantId: tenantId,
    propertyId: 'p-1',
    status: 'active',
    monthlyRent: 350,
    addressLabel: 'عمان - الصويفية، شارع الوكالات',
    daysUntilExpiry: daysLeft < 0 ? 0 : daysLeft,
    annualProgressDays: 120,
    annualTotalDays: 365,
    startYear: leaseStart.year,
    endYear: leaseEnd.year,
    leaseStartDate: leaseStart,
    leaseEndDate: leaseEnd,
    landlordId: prop?.ownerId,
    landlordName: prop?.ownerName,
  );
}

PropertyModel? propertyById(String id) {
  final agency = agencyPropertyById(id);
  if (agency != null) return agency;
  try {
    return mockProperties.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}

List<PropertyModel> filterProperties({
  String governorateFilter = 'الكل',
  String? districtFilter,
  int? minRooms,
  double? maxPrice,
}) {
  var list = mockProperties.toList();
  if (governorateFilter != 'الكل') {
    list = list.where((p) => p.governorate == governorateFilter).toList();
  }
  final district = districtFilter;
  if (governorateFilter != 'الكل' && district != null && district.isNotEmpty) {
    list = list.where((p) => p.district == district).toList();
  }
  final roomsMin = minRooms;
  if (roomsMin != null && roomsMin > 0) {
    list = list.where((p) => p.rooms >= roomsMin).toList();
  }
  final priceMax = maxPrice;
  if (priceMax != null && priceMax > 0) {
    list = list.where((p) => p.priceMonthly <= priceMax).toList();
  }
  return list;
}

/// صف عقد سابق في لوحة المستأجر (وهمي).
class TenantPastContractRow {
  const TenantPastContractRow({
    required this.landlordId,
    required this.landlordName,
    required this.label,
  });

  final String landlordId;
  final String landlordName;
  final String label;
}

List<TenantPastContractRow> mockPastContractRowsForTenant(String tenantId) {
  switch (tenantId) {
    case 'u-tenant-1':
      return const [
        TenantPastContractRow(
          landlordId: 'u-owner-2',
          landlordName: 'سارة الخالدي',
          label: '2024 — عقد منتهٍ',
        ),
        TenantPastContractRow(
          landlordId: 'u-owner-3',
          landlordName: 'عمر النابلسي',
          label: '2023 — استوديو إربد',
        ),
      ];
    case 'u-tenant-2':
      return const [
        TenantPastContractRow(
          landlordId: 'u-owner-3',
          landlordName: 'عمر النابلسي',
          label: '2023 — سكن طلابي',
        ),
      ];
    case 'u-tenant-3':
      return const [
        TenantPastContractRow(
          landlordId: 'u-owner-1',
          landlordName: 'محمد الأحمد',
          label: '2024 — عقد قصير',
        ),
      ];
    default:
      return const [];
  }
}

/// جميع المستخدمين الوهميين (للملف العام والبحث بالمعرف).
final List<UserModel> kAllMockUsers = [
  mockTenantUser,
  mockTenant2,
  mockTenant3,
  mockOwnerUser,
  mockOwner2,
  mockOwner3,
  mockOfficeUser,
  mockOfficeUser2,
  mockOfficeUser3,
];

UserModel? userById(String id) {
  for (final u in kAllMockUsers) {
    if (u.id == id) return u;
  }
  return null;
}

/// ثلاثة تقييمات وهمية لكل عقار (نفس المحتوى مع اختلاف بسيط حسب المعرّف).
List<PropertyReviewModel> mockReviewsForProperty(String propertyId) {
  final suffix = propertyId.hashCode.abs() % 10;
  return [
    PropertyReviewModel(
      authorName: 'ليلى الخطيب',
      rating: 5,
      comment:
          'تعامل راقٍ جداً، العقار كما في الصور، وعملية التسليم كانت سلسة. أنصح بالتعامل مع المالك.',
      timeLabel: 'منذ ${suffix + 1} أسابيع',
    ),
    PropertyReviewModel(
      authorName: 'طارق منصور',
      rating: 4,
      comment: 'موقع ممتاز وخدمات قريبة. أتمنى لو كان هناك موقف إضافي لكن بشكل عام تجربة جيدة.',
      timeLabel: 'منذ شهر',
    ),
    PropertyReviewModel(
      authorName: 'رنا السعدي',
      rating: 5,
      comment: 'إيجار مناسب مقارنة بالمنطقة، الاستجابة سريعة عبر المنصة.',
      timeLabel: 'منذ شهرين',
    ),
  ];
}

// ——— بيانات لوحة المالك (وهمية) ———

class OwnerRentedListingMock {
  const OwnerRentedListingMock({
    required this.id,
    required this.propertyTitle,
    required this.address,
    required this.tenantName,
    required this.tenantId,
    required this.contractId,
    required this.monthlyRent,
  });

  final String id;
  final String propertyTitle;
  final String address;
  final String tenantName;
  /// لربط سجل التقييم وسجل المستأجر.
  final String tenantId;
  /// معرف العقد (وهمي) لتقييم المستأجر مرة واحدة لكل عقد.
  final String contractId;
  final double monthlyRent;
}

class OwnerVacantListingMock {
  const OwnerVacantListingMock({
    required this.id,
    required this.propertyTitle,
    required this.address,
    required this.askingRent,
    required this.propertyId,
  });

  final String id;
  final String propertyTitle;
  final String address;
  final double askingRent;

  /// لربط مع قائمة العقارات إن وُجد.
  final String propertyId;
}

const mockOwnerRentedListings = <OwnerRentedListingMock>[
  OwnerRentedListingMock(
    id: 'or-1',
    propertyTitle: 'شقة — الصويفية',
    address: 'شارع الوكالات',
    tenantName: 'أحمد الأحمد',
    tenantId: 'u-tenant-1',
    contractId: 'c-or-1',
    monthlyRent: 350,
  ),
  OwnerRentedListingMock(
    id: 'or-2',
    propertyTitle: 'شقة — الدوار الرابع',
    address: 'عمان',
    tenantName: 'سارة فتحي',
    tenantId: 'u-tenant-2',
    contractId: 'c-or-2',
    monthlyRent: 420,
  ),
  OwnerRentedListingMock(
    id: 'or-3',
    propertyTitle: 'استوديو — الجبيهة',
    address: 'بالقرب من الجامعة',
    tenantName: 'خالد نعيرات',
    tenantId: 'u-tenant-3',
    contractId: 'c-or-3',
    monthlyRent: 280,
  ),
];

const mockOwnerVacantListings = <OwnerVacantListingMock>[
  OwnerVacantListingMock(
    id: 'ov-1',
    propertyTitle: 'شقة رووف — عبدون',
    address: 'عمان - عبدون',
    askingRent: 520,
    propertyId: 'p-5',
  ),
  OwnerVacantListingMock(
    id: 'ov-2',
    propertyTitle: 'بيت طابقين — ماركا',
    address: 'عمان - ماركا',
    askingRent: 380,
    propertyId: 'p-6',
  ),
];

/// إحصائيات ملخص لوحة المالك.
class OwnerDashboardStatsMock {
  const OwnerDashboardStatsMock({
    required this.rentedCount,
    required this.vacantCount,
    required this.totalMonthlyRent,
  });

  final int rentedCount;
  final int vacantCount;
  final double totalMonthlyRent;
}

OwnerDashboardStatsMock statsForOwnerDashboard() {
  final rented = mockOwnerRentedListings.length;
  final vacant = mockOwnerVacantListings.length;
  final total = mockOwnerRentedListings.fold<double>(0, (s, e) => s + e.monthlyRent);
  return OwnerDashboardStatsMock(
    rentedCount: rented,
    vacantCount: vacant,
    totalMonthlyRent: total,
  );
}
