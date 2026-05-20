import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Track Pace Calculator'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @selectLane.
  ///
  /// In en, this message translates to:
  /// **'Select lane'**
  String get selectLane;

  /// No description provided for @lapCount.
  ///
  /// In en, this message translates to:
  /// **'Lap count'**
  String get lapCount;

  /// No description provided for @lapUnit.
  ///
  /// In en, this message translates to:
  /// **' laps'**
  String get lapUnit;

  /// No description provided for @goalTime.
  ///
  /// In en, this message translates to:
  /// **'Goal time'**
  String get goalTime;

  /// No description provided for @secondsUnit.
  ///
  /// In en, this message translates to:
  /// **' sec'**
  String get secondsUnit;

  /// No description provided for @allLanesPace.
  ///
  /// In en, this message translates to:
  /// **'Pace by lane'**
  String get allLanesPace;

  /// No description provided for @laneLabel.
  ///
  /// In en, this message translates to:
  /// **'Lane {lane}'**
  String laneLabel(int lane);

  /// No description provided for @paceGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Pace guide'**
  String get paceGuideTitle;

  /// No description provided for @paceGuideMessage.
  ///
  /// In en, this message translates to:
  /// **'This pace is the per-km pace when you run {laps} lap(s) on lane {lane} in {seconds} seconds.'**
  String paceGuideMessage(int seconds, int laps, int lane);

  /// No description provided for @resultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Lane {lane} · {laps} lap(s) · {seconds}s'**
  String resultSubtitle(int lane, int laps, int seconds);

  /// No description provided for @sectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get sectionGeneral;

  /// No description provided for @sectionLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get sectionLanguage;

  /// No description provided for @sectionInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get sectionInfo;

  /// No description provided for @resetInput.
  ///
  /// In en, this message translates to:
  /// **'Reset input'**
  String get resetInput;

  /// No description provided for @resetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Lane 1 · 1 lap · 90 sec'**
  String get resetSubtitle;

  /// No description provided for @resetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButton;

  /// No description provided for @resetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset input'**
  String get resetDialogTitle;

  /// No description provided for @resetDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Reset to lane 1, 1 lap, and 90 seconds.'**
  String get resetDialogMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @directEditInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get directEditInvalid;

  /// No description provided for @directEditRange.
  ///
  /// In en, this message translates to:
  /// **'Enter a value between {min} and {max} seconds'**
  String directEditRange(int min, int max);

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get languageEnglishSubtitle;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// No description provided for @languageKoreanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get languageKoreanSubtitle;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get languageJapanese;

  /// No description provided for @languageJapaneseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapaneseSubtitle;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @languageChineseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChineseSubtitle;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @aboutMeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Developer info'**
  String get aboutMeSubtitle;

  /// No description provided for @devVersion.
  ///
  /// In en, this message translates to:
  /// **'Dev version v{version} ({build})'**
  String devVersion(String version, int build);

  /// No description provided for @resetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Input has been reset.'**
  String get resetSuccess;

  /// No description provided for @maxSecondsNotice.
  ///
  /// In en, this message translates to:
  /// **'Goal time can be set up to 3600 seconds (60 minutes).'**
  String get maxSecondsNotice;

  /// No description provided for @durationSecondsOnly.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String durationSecondsOnly(int seconds);

  /// No description provided for @durationMinutesOnly.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutesOnly(int minutes);

  /// No description provided for @durationMinutesSeconds.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min {seconds} sec'**
  String durationMinutesSeconds(int minutes, int seconds);

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @intro.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get intro;

  /// No description provided for @threads.
  ///
  /// In en, this message translates to:
  /// **'Threads'**
  String get threads;

  /// No description provided for @threadsHandle.
  ///
  /// In en, this message translates to:
  /// **'@{username}'**
  String threadsHandle(String username);

  /// No description provided for @usedLibraries.
  ///
  /// In en, this message translates to:
  /// **'Libraries used'**
  String get usedLibraries;

  /// No description provided for @developerBio.
  ///
  /// In en, this message translates to:
  /// **'\"If I run 90 seconds on the track,\nwhat pace per km is that?\"\n\nThis app started from a question\nrunners ask themselves at least once.\n\nWe factor in lane distance differences\nto deliver a more accurate pace.\n\nLess complexity—\nonly what you need.\n\nFor more focused training:\nTrack Pace Calculator.'**
  String get developerBio;

  /// No description provided for @linkOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link.'**
  String get linkOpenFailed;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Track Pace Calculator'**
  String get copyright;

  /// No description provided for @versionBuild.
  ///
  /// In en, this message translates to:
  /// **'v{version} (build {build})'**
  String versionBuild(String version, int build);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
