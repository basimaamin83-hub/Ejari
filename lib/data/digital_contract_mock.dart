import 'package:ejari/data/mock_data.dart' show mockOwnerUser, mockTenantUser;

/// نتيجة وهمية لاستعلام دائرة الأراضي والمساحة.
class MockLandRegistryParcel {
  const MockLandRegistryParcel({
    required this.deedNumber,
    required this.parcelNumber,
    required this.descriptionAr,
    required this.areaSqm,
    required this.linkedPropertyId,
    required this.regionLabel,
  });

  final String deedNumber;
  final String parcelNumber;
  final String descriptionAr;
  final int areaSqm;
  final String linkedPropertyId;
  final String regionLabel;
}

/// محاكاة جلب بيانات العقار من دائرة الأراضي (بدون API حقيقي).
Future<MockLandRegistryParcel> mockFetchLandRegistry({
  required String deedNumber,
  required String parcelNumber,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 700));
  if (deedNumber.trim().isEmpty || parcelNumber.trim().isEmpty) {
    throw Exception('أدخل رقم الصك ورقم القطعة');
  }
  final hash = (deedNumber + parcelNumber).hashCode.abs();
  final rnd = hash % 3;
  final areas = [118, 135, 98];
  final props = ['p-1', 'p-2', 'p-5'];
  return MockLandRegistryParcel(
    deedNumber: deedNumber.trim(),
    parcelNumber: parcelNumber.trim(),
    descriptionAr:
        'عقار سكني — شقة ضمن بناء قيد الإشارة — ${['الصويفية', 'الشميساني', 'الجبيهة'][rnd]} — عمان',
    areaSqm: areas[rnd],
    linkedPropertyId: props[rnd],
    regionLabel: 'لواء قصبة عمان / قضاء…',
  );
}

/// بيانات طرف من «الهوية الرقمية» (وهمي).
class MockDigitalIdProfile {
  const MockDigitalIdProfile({
    required this.fullNameAr,
    required this.nationalId,
    required this.phone,
  });

  final String fullNameAr;
  final String nationalId;
  final String phone;
}

/// محاكاة جلب ملف الهوية الرقمية.
Future<MockDigitalIdProfile> mockFetchDigitalId({required String nationalId}) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  final ownerId = mockOwnerUser.idNumber;
  if (ownerId != null && nationalId == ownerId) {
    return MockDigitalIdProfile(
      fullNameAr: mockOwnerUser.fullName,
      nationalId: ownerId,
      phone: mockOwnerUser.phone ?? '',
    );
  }
  final tenantId = mockTenantUser.idNumber;
  if (tenantId != null && nationalId == tenantId) {
    return MockDigitalIdProfile(
      fullNameAr: mockTenantUser.fullName,
      nationalId: tenantId,
      phone: mockTenantUser.phone ?? '',
    );
  }
  return MockDigitalIdProfile(
    fullNameAr: 'مواطن (وهمي)',
    nationalId: nationalId,
    phone: '+962 7X XXX XXXX',
  );
}
