import 'package:ejari/models/agency_models.dart';
import 'package:ejari/models/property_model.dart';

/// معرفات المكاتب الوهمية.
const String kAgency1Id = 'agency-1';
const String kAgency2Id = 'agency-2';

const String kAgency1Name = 'بيوت الأردن';
const String kAgency2Name = 'السكن المثالي';

AgencyProfile agencyProfileFor(String agencyId) {
  if (agencyId == kAgency2Id) {
    return const AgencyProfile(
      id: kAgency2Id,
      name: kAgency2Name,
      licenseNumber: 'RE-2021-8899',
      phone: '+962 6 777 8899',
      email: 'info@alsakan.jo',
      address: 'عمان — الدوار الرابع، برج النخيل',
      defaultCommissionPercent: 3.0,
    );
  }
  return const AgencyProfile(
    id: kAgency1Id,
    name: kAgency1Name,
    licenseNumber: 'RE-2019-1044',
    phone: '+962 6 555 0101',
    email: 'info@byut-jo.jo',
    address: 'عمان — عبدون، شارع الأمير محمد',
    defaultCommissionPercent: 2.5,
  );
}

/// طلبات الصيانة الوهمية الثلاثة لعقار «شقة دوبلكس — عبدون» (مربوطة بـ [PropertyModel.maintenanceRequests]).
final List<AgencyMaintenanceRequestModel> kMaintenanceRequestsAbdounDuplex = [
  AgencyMaintenanceRequestModel(
    id: 'mnt-a1-1',
    propertyId: 'ap-a1-1',
    tenantName: 'ليث المصري',
    description: 'تسرّب مياه من سقف الحمام بعد الأمطار الأخيرة.',
    reportedAt: DateTime(2026, 4, 2),
    status: 'open',
    imageFileName: 'صورة_السقف_20260402.jpg',
  ),
  AgencyMaintenanceRequestModel(
    id: 'mnt-a1-2',
    propertyId: 'ap-a1-1',
    tenantName: 'ليث المصري',
    description: 'إصلاح باب غرفة النوم — المفصلة مرتخية.',
    reportedAt: DateTime(2026, 3, 18),
    status: 'in_progress',
    imageFileName: null,
  ),
  AgencyMaintenanceRequestModel(
    id: 'mnt-a1-3',
    propertyId: 'ap-a1-1',
    tenantName: 'ليث المصري',
    description: 'استبدال مفاتيح كهرباء غرفة الجلوس.',
    reportedAt: DateTime(2026, 2, 5),
    status: 'completed',
    imageFileName: 'before_after_switches.png',
  ),
];

/// عقارات يديرها المكتب (منفصلة عن قائمة البحث العامة للوضوح).
final List<PropertyModel> kAgencyManagedPropertiesAll = [
  PropertyModel(
    id: 'ap-a1-1',
    title: 'شقة دوبلكس — عبدون',
    governorate: 'عمان',
    district: 'عبدون',
    location: 'عبدون - عمان',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 160,
    priceMonthly: 480,
    ownerName: 'محمد الأحمد',
    ownerRating: 4.9,
    rating: 4.7,
    reviewCount: 12,
    tags: ['مفروشة'],
    availableNow: false,
    description: '',
    imageSeeds: ['ejari-living-1'],
    ownerPhone: '+962791112233',
    ownerId: 'u-owner-1',
    agencyId: kAgency1Id,
    commissionRate: 2.5,
    maintenanceRequests: kMaintenanceRequestsAbdounDuplex,
  ),
  PropertyModel(
    id: 'ap-a1-2',
    title: 'استوديو — الجبيهة',
    governorate: 'عمان',
    district: 'الجبيهة',
    location: 'الجبيهة',
    rooms: 1,
    bathrooms: 1,
    areaSqm: 45,
    priceMonthly: 220,
    ownerName: 'سارة الخالدي',
    ownerRating: 4.7,
    rating: 4.5,
    reviewCount: 8,
    tags: ['قريب من الجامعة'],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-bed-1'],
    ownerPhone: '+962794445566',
    ownerId: 'u-owner-2',
    agencyId: kAgency1Id,
    commissionRate: 2.5,
  ),
  PropertyModel(
    id: 'ap-a1-3',
    title: 'رووف — الدوار الرابع',
    governorate: 'عمان',
    district: 'الرابعة',
    location: 'الدوار الرابع',
    rooms: 4,
    bathrooms: 3,
    areaSqm: 200,
    priceMonthly: 620,
    ownerName: 'عمر النابلسي',
    ownerRating: 4.6,
    rating: 4.8,
    reviewCount: 15,
    tags: ['رووف', 'مصعد'],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-naour-1'],
    ownerPhone: '+962795556677',
    ownerId: 'u-owner-3',
    agencyId: kAgency1Id,
    commissionRate: 3.0,
  ),
  PropertyModel(
    id: 'ap-a1-4',
    title: 'شقة — ضاحية الياسمين',
    governorate: 'عمان',
    district: 'الياسمين',
    location: 'ضاحية الياسمين',
    rooms: 2,
    bathrooms: 2,
    areaSqm: 95,
    priceMonthly: 310,
    ownerName: 'محمد الأحمد',
    ownerRating: 4.9,
    rating: 4.5,
    reviewCount: 5,
    tags: ['هادئ'],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-kitchen-1'],
    ownerPhone: '+962791112233',
    ownerId: 'u-owner-1',
    agencyId: kAgency1Id,
    commissionRate: 2.5,
  ),
  PropertyModel(
    id: 'ap-a1-5',
    title: 'محل تجاري — الجبيهة',
    governorate: 'عمان',
    district: 'الجبيهة',
    location: 'شارع الجامعة الأردنية',
    rooms: 1,
    bathrooms: 1,
    areaSqm: 55,
    priceMonthly: 400,
    ownerName: 'سارة الخالدي',
    ownerRating: 4.7,
    rating: 4.4,
    reviewCount: 7,
    tags: ['تجاري'],
    availableNow: false,
    description: '',
    imageSeeds: ['ejari-living-1'],
    ownerPhone: '+962794445566',
    ownerId: 'u-owner-2',
    agencyId: kAgency1Id,
    commissionRate: 2.5,
  ),
  PropertyModel(
    id: 'ap-a1-6',
    title: 'تاون هاوس — دابوق',
    governorate: 'عمان',
    district: 'دابوق',
    location: 'دابوق',
    rooms: 4,
    bathrooms: 3,
    areaSqm: 220,
    priceMonthly: 550,
    ownerName: 'عمر النابلسي',
    ownerRating: 4.6,
    rating: 4.7,
    reviewCount: 11,
    tags: ['حديقة'],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-naour-1'],
    ownerPhone: '+962795556677',
    ownerId: 'u-owner-3',
    agencyId: kAgency1Id,
    commissionRate: 3.0,
  ),
  PropertyModel(
    id: 'ap-a2-1',
    title: 'شقة عائلية — ماركا',
    governorate: 'عمان',
    district: 'ماركا',
    location: 'ماركا الشمالية',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 140,
    priceMonthly: 380,
    ownerName: 'محمد الأحمد',
    ownerRating: 4.9,
    rating: 4.4,
    reviewCount: 6,
    tags: [],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-kitchen-1'],
    ownerPhone: '+962791112233',
    ownerId: 'u-owner-1',
    agencyId: kAgency2Id,
    commissionRate: 3.0,
  ),
  PropertyModel(
    id: 'ap-a2-2',
    title: 'مكتب صغير — الشميساني',
    governorate: 'عمان',
    district: 'الشميساني',
    location: 'الشميساني',
    rooms: 2,
    bathrooms: 1,
    areaSqm: 85,
    priceMonthly: 290,
    ownerName: 'سارة الخالدي',
    ownerRating: 4.7,
    rating: 4.3,
    reviewCount: 4,
    tags: ['تجاري'],
    availableNow: false,
    description: '',
    imageSeeds: ['ejari-living-1'],
    ownerPhone: '+962794445566',
    ownerId: 'u-owner-2',
    agencyId: kAgency2Id,
    commissionRate: 3.0,
  ),
  PropertyModel(
    id: 'ap-a2-3',
    title: 'بيت مستقل — ناعور',
    governorate: 'عمان',
    district: 'ناعور',
    location: 'ناعور',
    rooms: 5,
    bathrooms: 3,
    areaSqm: 280,
    priceMonthly: 450,
    ownerName: 'عمر النابلسي',
    ownerRating: 4.6,
    rating: 4.6,
    reviewCount: 9,
    tags: ['حديقة'],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-bed-1'],
    ownerPhone: '+962795556677',
    ownerId: 'u-owner-3',
    agencyId: kAgency2Id,
    commissionRate: 2.75,
  ),
  PropertyModel(
    id: 'ap-a2-4',
    title: 'شقة — أبو نصير',
    governorate: 'عمان',
    district: 'أبو نصير',
    location: 'أبو نصير الغربي',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 130,
    priceMonthly: 340,
    ownerName: 'محمد الأحمد',
    ownerRating: 4.9,
    rating: 4.5,
    reviewCount: 4,
    tags: [],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-bed-1'],
    ownerPhone: '+962791112233',
    ownerId: 'u-owner-1',
    agencyId: kAgency2Id,
    commissionRate: 3.0,
  ),
  PropertyModel(
    id: 'ap-a2-5',
    title: 'رووف مكتبي — خلدا',
    governorate: 'عمان',
    district: 'خلدا',
    location: 'خلدا',
    rooms: 3,
    bathrooms: 2,
    areaSqm: 110,
    priceMonthly: 520,
    ownerName: 'سارة الخالدي',
    ownerRating: 4.7,
    rating: 4.6,
    reviewCount: 8,
    tags: ['تجاري', 'مصعد'],
    availableNow: false,
    description: '',
    imageSeeds: ['ejari-living-1'],
    ownerPhone: '+962794445566',
    ownerId: 'u-owner-2',
    agencyId: kAgency2Id,
    commissionRate: 3.0,
  ),
  PropertyModel(
    id: 'ap-a2-6',
    title: 'شقة سكنية — صويلح',
    governorate: 'عمان',
    district: 'صويلح',
    location: 'صويلح',
    rooms: 2,
    bathrooms: 1,
    areaSqm: 90,
    priceMonthly: 265,
    ownerName: 'عمر النابلسي',
    ownerRating: 4.6,
    rating: 4.3,
    reviewCount: 6,
    tags: ['قريب الخدمات'],
    availableNow: true,
    description: '',
    imageSeeds: ['ejari-kitchen-1'],
    ownerPhone: '+962795556677',
    ownerId: 'u-owner-3',
    agencyId: kAgency2Id,
    commissionRate: 2.75,
  ),
];

List<PropertyModel> agencyProperties(String agencyId) =>
    kAgencyManagedPropertiesAll.where((p) => p.agencyId == agencyId).toList();

PropertyModel? agencyPropertyById(String id) {
  try {
    return kAgencyManagedPropertiesAll.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}

final List<AgencyRentalRequest> kAgencyRentalRequestsAll = [
  AgencyRentalRequest(
    id: 'rq-a1-1',
    agencyId: kAgency1Id,
    tenantId: 'u-tenant-1',
    tenantName: 'أحمد الأحمد',
    propertyId: 'ap-a1-2',
    propertyTitle: 'استوديو — الجبيهة',
    submittedAt: DateTime(2026, 3, 28),
    status: 'pending',
  ),
  AgencyRentalRequest(
    id: 'rq-a1-2',
    agencyId: kAgency1Id,
    tenantId: 'u-tenant-2',
    tenantName: 'سارة فتحي',
    propertyId: 'ap-a1-1',
    propertyTitle: 'شقة دوبلكس — عبدون',
    submittedAt: DateTime(2026, 3, 20),
    status: 'accepted',
  ),
  AgencyRentalRequest(
    id: 'rq-a1-3',
    agencyId: kAgency1Id,
    tenantId: 'u-tenant-3',
    tenantName: 'خالد نعيرات',
    propertyId: 'ap-a1-3',
    propertyTitle: 'رووف — الدوار الرابع',
    submittedAt: DateTime(2026, 3, 10),
    status: 'rejected',
  ),
  AgencyRentalRequest(
    id: 'rq-a2-1',
    agencyId: kAgency2Id,
    tenantId: 'u-tenant-2',
    tenantName: 'سارة فتحي',
    propertyId: 'ap-a2-1',
    propertyTitle: 'شقة عائلية — ماركا',
    submittedAt: DateTime(2026, 3, 25),
    status: 'pending',
  ),
  AgencyRentalRequest(
    id: 'rq-a2-2',
    agencyId: kAgency2Id,
    tenantId: 'u-tenant-1',
    tenantName: 'أحمد الأحمد',
    propertyId: 'ap-a2-3',
    propertyTitle: 'بيت مستقل — ناعور',
    submittedAt: DateTime(2026, 3, 18),
    status: 'pending',
  ),
  AgencyRentalRequest(
    id: 'rq-a2-3',
    agencyId: kAgency2Id,
    tenantId: 'u-tenant-3',
    tenantName: 'خالد نعيرات',
    propertyId: 'ap-a2-2',
    propertyTitle: 'مكتب صغير — الشميساني',
    submittedAt: DateTime(2026, 2, 5),
    status: 'accepted',
  ),
];

List<AgencyRentalRequest> agencyRequestsFor(String agencyId) =>
    kAgencyRentalRequestsAll.where((r) => r.agencyId == agencyId).toList();

AgencyRentalRequest? agencyRequestById(String id) {
  try {
    return kAgencyRentalRequestsAll.firstWhere((r) => r.id == id);
  } catch (_) {
    return null;
  }
}

final List<AgencyContractRecord> kAgencyContractsAll = [
  AgencyContractRecord(
    id: 'ac-a1-1',
    agencyId: kAgency1Id,
    propertyTitle: 'شقة دوبلكس — عبدون',
    tenantName: 'ليث المصري',
    landlordName: 'محمد الأحمد',
    startDate: DateTime(2025, 6, 1),
    endDate: DateTime(2026, 5, 31),
    monthlyRent: 480,
    commissionPercent: 2.5,
    status: 'active',
    tenantId: 'u-tenant-2',
    landlordId: 'u-owner-1',
  ),
  AgencyContractRecord(
    id: 'ac-a1-2',
    agencyId: kAgency1Id,
    propertyTitle: 'استوديو — الجبيهة',
    tenantName: 'نورا الزعبي',
    landlordName: 'سارة الخالدي',
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 12, 31),
    monthlyRent: 220,
    commissionPercent: 2.5,
    status: 'expired',
    tenantId: 'u-tenant-3',
    landlordId: 'u-owner-2',
  ),
  AgencyContractRecord(
    id: 'ac-a2-1',
    agencyId: kAgency2Id,
    propertyTitle: 'شقة عائلية — ماركا',
    tenantName: 'أحمد الأحمد',
    landlordName: 'محمد الأحمد',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2026, 8, 31),
    monthlyRent: 380,
    commissionPercent: 3.0,
    status: 'active',
    tenantId: 'u-tenant-1',
    landlordId: 'u-owner-1',
  ),
  AgencyContractRecord(
    id: 'ac-a2-2',
    agencyId: kAgency2Id,
    propertyTitle: 'مكتب صغير — الشميساني',
    tenantName: 'خالد نعيرات',
    landlordName: 'سارة الخالدي',
    startDate: DateTime(2023, 3, 1),
    endDate: DateTime(2024, 2, 29),
    monthlyRent: 290,
    commissionPercent: 3.0,
    status: 'expired',
    tenantId: 'u-tenant-3',
    landlordId: 'u-owner-2',
  ),
];

List<AgencyContractRecord> agencyContractsFor(String agencyId) =>
    kAgencyContractsAll.where((c) => c.agencyId == agencyId).toList();

final List<AgencyOwnerRecord> kAgencyOwnersAll = [
  AgencyOwnerRecord(
    ownerId: 'u-owner-1',
    agencyId: kAgency1Id,
    fullName: 'محمد الأحمد',
    phone: '+962 79 111 2233',
    managedPropertiesCount: 2,
    rating: 4.9,
  ),
  AgencyOwnerRecord(
    ownerId: 'u-owner-2',
    agencyId: kAgency1Id,
    fullName: 'سارة الخالدي',
    phone: '+962 79 444 5566',
    managedPropertiesCount: 2,
    rating: 4.7,
  ),
  AgencyOwnerRecord(
    ownerId: 'u-owner-3',
    agencyId: kAgency1Id,
    fullName: 'عمر النابلسي',
    phone: '+962 79 555 6677',
    managedPropertiesCount: 2,
    rating: 4.6,
  ),
  AgencyOwnerRecord(
    ownerId: 'u-owner-1',
    agencyId: kAgency2Id,
    fullName: 'محمد الأحمد',
    phone: '+962 79 111 2233',
    managedPropertiesCount: 2,
    rating: 4.9,
  ),
  AgencyOwnerRecord(
    ownerId: 'u-owner-2',
    agencyId: kAgency2Id,
    fullName: 'سارة الخالدي',
    phone: '+962 79 444 5566',
    managedPropertiesCount: 2,
    rating: 4.7,
  ),
  AgencyOwnerRecord(
    ownerId: 'u-owner-3',
    agencyId: kAgency2Id,
    fullName: 'عمر النابلسي',
    phone: '+962 79 555 6677',
    managedPropertiesCount: 2,
    rating: 4.6,
  ),
];

List<AgencyOwnerRecord> agencyOwnersFor(String agencyId) =>
    kAgencyOwnersAll.where((o) => o.agencyId == agencyId).toList();

final List<AgencyCommissionRecord> kAgencyCommissionsAll = [
  AgencyCommissionRecord(
    id: 'cm-a1-1',
    agencyId: kAgency1Id,
    contractDate: DateTime(2025, 6, 1),
    propertyTitle: 'شقة دوبلكس — عبدون',
    landlordName: 'محمد الأحمد',
    annualRent: 480 * 12,
    commissionPercent: 2.5,
    amountDue: 480 * 12 * 0.025,
    paid: true,
    contractId: 'ac-a1-1',
  ),
  AgencyCommissionRecord(
    id: 'cm-a1-2',
    agencyId: kAgency1Id,
    contractDate: DateTime(2026, 1, 10),
    propertyTitle: 'رووف — الدوار الرابع',
    landlordName: 'عمر النابلسي',
    annualRent: 620 * 12,
    commissionPercent: 3.0,
    amountDue: 620 * 12 * 0.03,
    paid: false,
    contractId: null,
  ),
  AgencyCommissionRecord(
    id: 'cm-a2-1',
    agencyId: kAgency2Id,
    contractDate: DateTime(2025, 9, 1),
    propertyTitle: 'شقة عائلية — ماركا',
    landlordName: 'محمد الأحمد',
    annualRent: 380 * 12,
    commissionPercent: 3.0,
    amountDue: 380 * 12 * 0.03,
    paid: false,
    contractId: 'ac-a2-1',
  ),
  AgencyCommissionRecord(
    id: 'cm-a2-2',
    agencyId: kAgency2Id,
    contractDate: DateTime(2024, 3, 1),
    propertyTitle: 'مكتب صغير — الشميساني',
    landlordName: 'سارة الخالدي',
    annualRent: 290 * 12,
    commissionPercent: 3.0,
    amountDue: 290 * 12 * 0.03,
    paid: true,
    contractId: 'ac-a2-2',
  ),
];

List<AgencyCommissionRecord> agencyCommissionsFor(String agencyId) =>
    kAgencyCommissionsAll.where((c) => c.agencyId == agencyId).toList();

/// إجمالي العمولات المستحقة (غير المدفوعة) لكل مالك.
Map<String, double> agencyCommissionTotalsDueByLandlord(String agencyId) {
  final map = <String, double>{};
  for (final c in agencyCommissionsFor(agencyId)) {
    if (c.paid) continue;
    map[c.landlordName] = (map[c.landlordName] ?? 0) + c.amountDue;
  }
  return map;
}

List<AgencyMaintenanceRequestModel> agencyMaintenanceForProperty(String propertyId) {
  final p = agencyPropertyById(propertyId);
  if (p == null) return const [];
  return List<AgencyMaintenanceRequestModel>.from(p.maintenanceRequests);
}

/// سجلات دفع إيجار وهمية لعقار ap-a1-1.
final List<AgencyRentPaymentRecord> kAgencyRentPaymentsAll = [
  AgencyRentPaymentRecord(
    id: 'pay-a1-1',
    propertyId: 'ap-a1-1',
    tenantName: 'ليث المصري',
    dueDate: DateTime(2026, 4, 1),
    paidDate: DateTime(2026, 3, 30),
    amount: 480,
    isPaid: true,
  ),
  AgencyRentPaymentRecord(
    id: 'pay-a1-2',
    propertyId: 'ap-a1-1',
    tenantName: 'ليث المصري',
    dueDate: DateTime(2026, 5, 1),
    paidDate: null,
    amount: 480,
    isPaid: false,
  ),
  AgencyRentPaymentRecord(
    id: 'pay-a1-3',
    propertyId: 'ap-a1-1',
    tenantName: 'ليث المصري',
    dueDate: DateTime(2026, 3, 1),
    paidDate: null,
    amount: 480,
    isPaid: false,
  ),
  AgencyRentPaymentRecord(
    id: 'pay-a1-2a',
    propertyId: 'ap-a1-2',
    tenantName: 'نورا الزعبي',
    dueDate: DateTime(2026, 4, 10),
    paidDate: DateTime(2026, 4, 8),
    amount: 220,
    isPaid: true,
  ),
];

List<AgencyRentPaymentRecord> agencyRentPaymentsForProperty(String propertyId) =>
    kAgencyRentPaymentsAll.where((p) => p.propertyId == propertyId).toList();

AgencyRentPaymentDisplayStatus agencyRentPaymentDisplayStatus(AgencyRentPaymentRecord p) {
  if (p.isPaid) return AgencyRentPaymentDisplayStatus.paid;
  final now = DateTime.now();
  final due = DateTime(p.dueDate.year, p.dueDate.month, p.dueDate.day);
  final today = DateTime(now.year, now.month, now.day);
  if (today.isAfter(due)) return AgencyRentPaymentDisplayStatus.overdue;
  return AgencyRentPaymentDisplayStatus.pending;
}

/// تذكيرات وهمية (قبل 5 أيام من الاستحقاق) — إشعارات داخل التطبيق.
final List<AgencyRentDueReminder> kAgencyRentRemindersAll = [
  AgencyRentDueReminder(
    id: 'rem-a1-1',
    agencyId: kAgency1Id,
    propertyId: 'ap-a1-1',
    propertyTitle: 'شقة دوبلكس — عبدون',
    tenantName: 'ليث المصري',
    dueDate: DateTime(2026, 5, 1),
  ),
  AgencyRentDueReminder(
    id: 'rem-a1-2',
    agencyId: kAgency1Id,
    propertyId: 'ap-a1-2',
    propertyTitle: 'استوديو — الجبيهة',
    tenantName: 'نورا الزعبي',
    dueDate: DateTime(2026, 4, 15),
  ),
];

List<AgencyRentDueReminder> agencyRentRemindersFor(String agencyId) =>
    kAgencyRentRemindersAll.where((r) => r.agencyId == agencyId).toList();

final List<AgencyLegalConsultRecord> kAgencyLegalConsultsAll = [
  AgencyLegalConsultRecord(
    id: 'leg-a1-1',
    agencyId: kAgency1Id,
    issueType: 'نزاع على التأخير في التسليم',
    description: 'المالك يطالب بتعويض عن يومين تأخير في تسليم المفتاح.',
    submittedAt: DateTime(2026, 3, 22),
    status: 'قيد المراجعة',
  ),
];

List<AgencyLegalConsultRecord> agencyLegalConsultsFor(String agencyId) =>
    kAgencyLegalConsultsAll.where((c) => c.agencyId == agencyId).toList();

final List<AgencyBusinessLicenseRequest> kAgencyLicenseRequestsAll = [
  AgencyBusinessLicenseRequest(
    id: 'lic-a1-1',
    agencyId: kAgency1Id,
    propertyName: 'محل — جبل عمان',
    businessActivity: 'مقهى',
    buildingNumber: '12',
    submittedAt: DateTime(2026, 2, 10),
    status: 'مُرسل للبلدية',
  ),
  AgencyBusinessLicenseRequest(
    id: 'lic-a1-2',
    agencyId: kAgency1Id,
    propertyName: 'مكتب — الشميساني',
    businessActivity: 'خدمات عقارية',
    buildingNumber: '45',
    submittedAt: DateTime(2026, 3, 1),
    status: 'قيد المتابعة',
  ),
  AgencyBusinessLicenseRequest(
    id: 'lic-a2-1',
    agencyId: kAgency2Id,
    propertyName: 'صيدلية — مرج الحمام',
    businessActivity: 'صيدلية',
    buildingNumber: '3',
    submittedAt: DateTime(2026, 1, 20),
    status: 'مُرسل للبلدية',
  ),
];

List<AgencyBusinessLicenseRequest> agencyLicenseRequestsFor(String agencyId) =>
    kAgencyLicenseRequestsAll.where((l) => l.agencyId == agencyId).toList();

/// عدد مشاهدات وهمي لعقار (لوحة المكتب / التسويق).
int agencyPropertyMockViewCount(String propertyId) {
  return 150;
}

final List<AgencyOfficeReview> kAgencyReviewsAll = [
  AgencyOfficeReview(
    id: 'rv-a1-1',
    agencyId: kAgency1Id,
    authorName: 'مستأجر سابق',
    reviewedAt: DateTime(2026, 2, 1),
    stars: 5,
    comment: 'تعامل احترافي وتسويق سريع للعقار.',
  ),
  AgencyOfficeReview(
    id: 'rv-a1-2',
    agencyId: kAgency1Id,
    authorName: 'مالك عقار',
    reviewedAt: DateTime(2025, 11, 15),
    stars: 4,
    comment: 'خدمة جيدة، أتمنى تقارير شهرية أوضح.',
  ),
  AgencyOfficeReview(
    id: 'rv-a1-3',
    agencyId: kAgency1Id,
    authorName: 'سارة م.',
    reviewedAt: DateTime(2025, 8, 3),
    stars: 5,
    comment: null,
  ),
  AgencyOfficeReview(
    id: 'rv-a2-1',
    agencyId: kAgency2Id,
    authorName: 'عميل',
    reviewedAt: DateTime(2026, 1, 20),
    stars: 4,
    comment: 'مكتب منظم والمتابعة بعد التوقيع ممتازة.',
  ),
  AgencyOfficeReview(
    id: 'rv-a2-2',
    agencyId: kAgency2Id,
    authorName: 'خالد ن.',
    reviewedAt: DateTime(2025, 10, 8),
    stars: 3,
    comment: 'جيد لكن الرد أحياناً يتأخر.',
  ),
];

List<AgencyOfficeReview> agencyReviewsFor(String agencyId) =>
    kAgencyReviewsAll.where((r) => r.agencyId == agencyId).toList();

/// إحصاءات عليا للوحة المكتب.
class AgencyDashboardStats {
  const AgencyDashboardStats({
    required this.publishedProperties,
    required this.linkedOwnersCount,
    required this.completedContracts,
    required this.totalCommissionsDue,
  });

  final int publishedProperties;
  /// عدد المالكين المرتبطين بالمكتب (وهمي).
  final int linkedOwnersCount;
  final int completedContracts;
  final double totalCommissionsDue;
}

AgencyDashboardStats agencyDashboardStats(String agencyId) {
  final props = agencyProperties(agencyId);
  final owners = agencyOwnersFor(agencyId).length;
  final contracts = agencyContractsFor(agencyId).length;
  final due = agencyCommissionsFor(agencyId)
      .where((c) => !c.paid)
      .fold<double>(0, (s, c) => s + c.amountDue);
  return AgencyDashboardStats(
    publishedProperties: props.length,
    linkedOwnersCount: owners,
    completedContracts: contracts,
    totalCommissionsDue: due,
  );
}

/// عقارات المكتب التابعة لمالك محدد.
List<PropertyModel> agencyPropertiesForOwner(String agencyId, String ownerId) =>
    agencyProperties(agencyId).where((p) => p.ownerId == ownerId).toList();
