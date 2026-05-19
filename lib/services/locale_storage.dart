import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 언어 설정 로컬 저장.
class LocaleStorage {
  LocaleStorage._();

  static const String keyLanguageCode = 'app_language_code';

  static const String koreanCode = 'ko';
  static const String englishCode = 'en';

  static Future<Locale> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(keyLanguageCode) ?? koreanCode;
    return Locale(code);
  }

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLanguageCode, locale.languageCode);
  }
}
