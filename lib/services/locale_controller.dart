import 'package:flutter/material.dart';

import 'locale_storage.dart';

/// 앱 전역 로케일 상태.
class LocaleController extends ChangeNotifier {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  Locale _locale = LocaleStorage.defaultLocale;

  Locale get locale => _locale;

  bool isSelected(String languageCode) =>
      _locale.languageCode == languageCode;

  Future<void> initialize() async {
    _locale = await LocaleStorage.loadLocale();
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final resolved = LocaleStorage.localeForLanguageCode(locale.languageCode);
    if (_locale == resolved) {
      return;
    }
    _locale = resolved;
    await LocaleStorage.saveLocale(resolved);
    notifyListeners();
  }

  Future<void> setEnglish() =>
      setLocale(const Locale(LocaleStorage.englishCode));

  Future<void> setKorean() =>
      setLocale(const Locale(LocaleStorage.koreanCode));

  Future<void> setJapanese() =>
      setLocale(const Locale(LocaleStorage.japaneseCode));

  Future<void> setChinese() =>
      setLocale(const Locale(LocaleStorage.chineseCode));
}
