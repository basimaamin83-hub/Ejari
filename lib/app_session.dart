import 'package:flutter/foundation.dart';
import 'package:ejari/data/mock_data.dart';
import 'package:ejari/data/sanad_login_mock.dart';
import 'package:ejari/data/sanad_users_mock_store.dart';
import 'package:ejari/data/sanad_account_preferences.dart';
import 'package:ejari/models/user_model.dart';
import 'package:ejari/state/tenant_contract_notifier.dart';

/// جلسة بسيطة للوضع التجريبي (ضيف / مستخدم مسجّل).
final class EjariSession extends ChangeNotifier {
  bool isGuest = true;
  UserModel? user;

  /// هوية سند المعلّقة بعد التحقق وقبل اختيار نوع الحساب.
  SanadIdentity? pendingSanadIdentity;

  void loginAsTenant() {
    isGuest = false;
    user = mockTenantUser;
    pendingSanadIdentity = null;
    notifyListeners();
  }

  void loginAsOwner() {
    isGuest = false;
    user = mockOwnerUser;
    pendingSanadIdentity = null;
    notifyListeners();
  }

  void loginAsOffice() {
    isGuest = false;
    user = mockOfficeUser;
    pendingSanadIdentity = null;
    notifyListeners();
  }

  void setPendingSanadIdentity(SanadIdentity identity) {
    pendingSanadIdentity = identity;
    notifyListeners();
  }

  void clearPendingSanadIdentity() {
    pendingSanadIdentity = null;
    notifyListeners();
  }

  /// بعد اختيار نوع الحساب: حفظ دائم لنوع الحساب + تحديث قاعدة وهمية + جلسة.
  Future<void> completeSanadLogin(SanadAccountKind kind) async {
    final pending = pendingSanadIdentity;
    if (pending == null) return;
    final model = userModelFromSanadAndKind(pending, kind);
    await SanadAccountPreferences.saveAccountKind(pending.nationalId, kind);
    SanadUsersMockStore.upsert(model, pending);
    isGuest = false;
    user = model;
    pendingSanadIdentity = null;
    notifyListeners();
  }

  /// مستخدم عاد بنفس رقم الهوية: تسجيل دخول مباشر دون شاشة الاختيار.
  Future<void> loginWithStoredAccountKind(SanadIdentity fresh, SanadAccountKind kind) async {
    final model = userModelFromSanadAndKind(fresh, kind);
    SanadUsersMockStore.upsert(model, fresh);
    isGuest = false;
    user = model;
    pendingSanadIdentity = null;
    notifyListeners();
  }

  void enterAsGuest() {
    isGuest = true;
    user = null;
    pendingSanadIdentity = null;
    notifyListeners();
  }

  void logout() {
    isGuest = true;
    user = null;
    pendingSanadIdentity = null;
    tenantContractNotifier.reset();
    notifyListeners();
  }

  String get displayFirstName {
    if (isGuest || user == null) return 'زائر';
    final parts = user!.fullName.trim().split(RegExp(r'\s+'));
    return parts.isNotEmpty ? parts.first : 'زائر';
  }
}

final ejariSession = EjariSession();
