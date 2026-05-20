import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:track/services/locale_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('save and load locale', () async {
    await LocaleStorage.saveLocale(const Locale('ja'));
    final loaded = await LocaleStorage.loadLocale();
    expect(loaded.languageCode, 'ja');
  });

  test('defaults to English when no saved preference', () async {
    final loaded = await LocaleStorage.loadLocale();
    expect(loaded.languageCode, LocaleStorage.englishCode);
  });

  test('localeForLanguageCode maps supported codes', () {
    expect(
      LocaleStorage.localeForLanguageCode('ko').languageCode,
      'ko',
    );
    expect(
      LocaleStorage.localeForLanguageCode('ja').languageCode,
      'ja',
    );
    expect(
      LocaleStorage.localeForLanguageCode('zh').languageCode,
      'zh',
    );
    expect(
      LocaleStorage.localeForLanguageCode('zh_TW').languageCode,
      'zh',
    );
  });

  test('localeForLanguageCode falls back to English', () {
    expect(
      LocaleStorage.localeForLanguageCode('fr').languageCode,
      'en',
    );
    expect(
      LocaleStorage.localeForLanguageCode('de').languageCode,
      'en',
    );
  });
}
