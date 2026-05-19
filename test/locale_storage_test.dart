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
    await LocaleStorage.saveLocale(const Locale('en'));
    final loaded = await LocaleStorage.loadLocale();
    expect(loaded.languageCode, 'en');
  });

  test('defaults to Korean', () async {
    final loaded = await LocaleStorage.loadLocale();
    expect(loaded.languageCode, LocaleStorage.koreanCode);
  });
}
