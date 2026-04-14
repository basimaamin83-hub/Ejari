import 'package:ejari/data/sanad_login_mock.dart';
import 'package:ejari/models/user_model.dart';

/// قاعدة بيانات وهمية لمستخدمي سند (ذاكرة فقط).
abstract final class SanadUsersMockStore {
  static final Map<String, Map<String, dynamic>> _rows = {};

  static void upsert(UserModel user, SanadIdentity identity) {
    _rows[user.id] = {
      'user': user,
      'identity': identity.toJson(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  static int get count => _rows.length;
}
