import 'package:flutter/material.dart';

import 'locale_storage.dart';

/// 앱 전역 로케일 상태.
class LocaleController extends ChangeNotifier {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  Locale _locale = const Locale(LocaleStorage.koreanCode);

  Locale get locale => _locale;

  bool get isKorean => _locale.languageCode == LocaleStorage.koreanCode;

  Future<void> initialize() async {
    _locale = await LocaleStorage.loadLocale();
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    await LocaleStorage.saveLocale(locale);
    notifyListeners();
  }

  Future<void> setKorean() => setLocale(const Locale(LocaleStorage.koreanCode));

  Future<void> setEnglish() => setLocale(const Locale(LocaleStorage.englishCode));
}
