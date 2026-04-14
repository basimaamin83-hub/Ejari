import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocalePrefKey = 'ejari_app_locale';

/// Holds the app [Locale], persists it, and notifies listeners when it changes.
final LocaleNotifier ejariLocaleNotifier = LocaleNotifier();

class LocaleNotifier extends ChangeNotifier {
  LocaleNotifier() : _locale = const Locale('ar');

  Locale _locale;
  Locale get locale => _locale;

  bool _loaded = false;
  bool get hasLoaded => _loaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kLocalePrefKey);
    if (code == 'en') {
      _locale = const Locale('en');
    } else if (code == 'ar') {
      _locale = const Locale('ar');
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final code = locale.languageCode;
    if (code != 'ar' && code != 'en') return;
    if (_locale.languageCode == code) return;
    _locale = Locale(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocalePrefKey, code);
  }

  Future<void> toggleArEn() async {
    await setLocale(_locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
  }
}
