import 'package:ejari/data/agency_mock_data.dart';
import 'package:ejari/models/user_model.dart';

/// نوع الحساب الذي يختاره المستخدم بعد التحقق من سند.
enum SanadAccountKind {
  tenant,
  landlord,
  agency,
}

/// بيانات الهوية كما تُرجعها خدمة سند (بدون نوع حساب — يُحدَّد لاحقاً).
class SanadIdentity {
  const SanadIdentity({
    required this.fullName,
    required this.nationalId,
    required this.phone,
    required this.email,
  });

  final String fullName;
  final String nationalId;
  final String phone;
  final String email;

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'nationalId': nationalId,
        'phone': phone,
        'email': email,
      };
}

/// محاكاة التحقق من سند ثم استلام بيانات الهوية فقط (JSON وهمي).
Future<SanadIdentity> simulateSanadLogin({
  required String nationalId,
  required String pin,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 1400));
  final trimmedId = nationalId.trim();
  return SanadIdentity(
    fullName: 'أحمد محمد',
    nationalId: trimmedId.isEmpty ? '9851234567' : trimmedId,
    phone: '0791234567',
    email: 'ahmad@example.com',
  );
}

/// بناء مستخدم إيجاري من هوية سند + نوع الحساب المختار.
UserModel userModelFromSanadAndKind(SanadIdentity id, SanadAccountKind kind) {
  final role = switch (kind) {
    SanadAccountKind.tenant => 'tenant',
    SanadAccountKind.landlord => 'owner',
    SanadAccountKind.agency => 'office',
  };

  final isAgency = kind == SanadAccountKind.agency;

  return UserModel(
    id: 'sanad-${id.nationalId}',
    fullName: id.fullName,
    role: role,
    idNumber: id.nationalId,
    phone: id.phone,
    email: id.email,
    registeredAt: DateTime.now(),
    isVerified: true,
    userType: isAgency ? 'agency' : kind.name,
    agencyId: isAgency ? kAgency1Id : null,
    defaultCommissionRate: isAgency ? 2.5 : null,
  );
}
