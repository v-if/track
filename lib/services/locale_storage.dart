import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 언어 설정 로컬 저장 및 시스템 로케일 해석.
class LocaleStorage {
  LocaleStorage._();

  static const String keyLanguageCode = 'app_language_code';

  static const String englishCode = 'en';
  static const String koreanCode = 'ko';
  static const String japaneseCode = 'ja';
  static const String chineseCode = 'zh';

  static const List<String> supportedLanguageCodes = [
    englishCode,
    koreanCode,
    japaneseCode,
    chineseCode,
  ];

  static const Locale defaultLocale = Locale(englishCode);

  /// 저장된 언어가 있으면 사용, 없으면 시스템 언어로 결정.
  static Future<Locale> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(keyLanguageCode);
    if (saved != null && isSupportedLanguageCode(saved)) {
      return Locale(saved);
    }
    return resolveSystemLocale();
  }

  /// 시스템 언어가 지원 목록(ko/ja/zh)이면 해당 언어, 그 외는 영어.
  static Locale resolveSystemLocale() {
    final systemCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return localeForLanguageCode(systemCode);
  }

  static bool isSupportedLanguageCode(String code) {
    return supportedLanguageCodes.contains(code);
  }

  static Locale localeForLanguageCode(String code) {
    switch (code) {
      case koreanCode:
        return const Locale(koreanCode);
      case japaneseCode:
        return const Locale(japaneseCode);
      case chineseCode:
        return const Locale(chineseCode);
      default:
        if (code.startsWith('zh')) {
          return const Locale(chineseCode);
        }
        return defaultLocale;
    }
  }

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLanguageCode, locale.languageCode);
  }

  static Future<void> clearSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyLanguageCode);
  }
}
