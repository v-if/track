import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:track/utils/time_format.dart';

void main() {
  group('formatMinutesSeconds', () {
    testWidgets('Korean locale', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ko'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              expect(formatMinutesSeconds(context, 170), '2분 50초');
              expect(formatMinutesSeconds(context, 90), '1분 30초');
              expect(formatMinutesSeconds(context, 45), '45초');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('English locale', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              expect(formatMinutesSeconds(context, 170), '2 min 50 sec');
              expect(formatMinutesSeconds(context, 90), '1 min 30 sec');
              expect(formatMinutesSeconds(context, 45), '45s');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('scaleSecondsForLaps', () {
    test('scales proportionally', () {
      expect(
        scaleSecondsForLaps(
          currentSeconds: 90,
          oldLaps: 1,
          newLaps: 2,
          minSeconds: 1,
          maxSeconds: 3600,
        ),
        180,
      );
    });
  });
}
