class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.role,
    this.idNumber,
    this.phone,
    this.email,
    this.registeredAt,
    this.isVerified = false,
    /// tenant | owner | office — أو استخدم [userType] للتمييز الدقيق.
    this.userType,
    /// عند تسجيل دخول مكتب عقاري: معرف المكتب في النظام.
    this.agencyId,
    /// نسبة العمولة الافتراضية للمكتب (مثلاً 2.5 يعني 2.5٪).
    this.defaultCommissionRate,
  });

  final String id;
  final String fullName;
  final String role;
  final String? idNumber;
  final String? phone;
  final String? email;
  final DateTime? registeredAt;
  final bool isVerified;

  /// مثل `agency` للمكاتب العقارية (يمكن أن يطابق role أو يُستخرج منه).
  final String? userType;
  final String? agencyId;
  final double? defaultCommissionRate;
}
