import 'package:shared_preferences/shared_preferences.dart';
import 'package:ejari/data/sanad_login_mock.dart';

/// يحفظ نوع الحساب المرتبط برقم الهوية الوطنية حتى لا يُطلب الاختيار مرة أخرى.
abstract final class SanadAccountPreferences {
  static String _key(String nationalId) => 'ejari_sanad_account_kind_$nationalId';

  static Future<void> saveAccountKind(String nationalId, SanadAccountKind kind) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_key(nationalId), kind.name);
  }

  static Future<SanadAccountKind?> getSavedKind(String nationalId) async {
    final p = await SharedPreferences.getInstance();
    final s = p.getString(_key(nationalId));
    if (s == null || s.isEmpty) return null;
    for (final k in SanadAccountKind.values) {
      if (k.name == s) return k;
    }
    return null;
  }
}
