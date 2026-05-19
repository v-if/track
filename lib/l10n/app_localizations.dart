import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

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
    Locale('ko'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ko, this message translates to:
  /// **'트랙 페이스 계산기'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settings;

  /// No description provided for @settingsTooltip.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settingsTooltip;

  /// No description provided for @selectLane.
  ///
  /// In ko, this message translates to:
  /// **'레인 선택'**
  String get selectLane;

  /// No description provided for @lapCount.
  ///
  /// In ko, this message translates to:
  /// **'랩 카운트'**
  String get lapCount;

  /// No description provided for @lapUnit.
  ///
  /// In ko, this message translates to:
  /// **'랩'**
  String get lapUnit;

  /// No description provided for @goalTime.
  ///
  /// In ko, this message translates to:
  /// **'목표 시간'**
  String get goalTime;

  /// No description provided for @secondsUnit.
  ///
  /// In ko, this message translates to:
  /// **'초'**
  String get secondsUnit;

  /// No description provided for @allLanesPace.
  ///
  /// In ko, this message translates to:
  /// **'레인별 페이스표'**
  String get allLanesPace;

  /// No description provided for @laneLabel.
  ///
  /// In ko, this message translates to:
  /// **'{lane}레인'**
  String laneLabel(int lane);

  /// No description provided for @paceGuideTitle.
  ///
  /// In ko, this message translates to:
  /// **'페이스 가이드'**
  String get paceGuideTitle;

  /// No description provided for @paceGuideMessage.
  ///
  /// In ko, this message translates to:
  /// **'이 페이스는 목표시간 {seconds}초로 {laps}랩({lane}레인)를 뛰었을 때의 1km 기준 페이스 입니다.'**
  String paceGuideMessage(int seconds, int laps, int lane);

  /// No description provided for @resultSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'{lane}레인 · {laps}랩 · {seconds}초'**
  String resultSubtitle(int lane, int laps, int seconds);

  /// No description provided for @sectionGeneral.
  ///
  /// In ko, this message translates to:
  /// **'일반'**
  String get sectionGeneral;

  /// No description provided for @sectionLanguage.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get sectionLanguage;

  /// No description provided for @sectionInfo.
  ///
  /// In ko, this message translates to:
  /// **'정보'**
  String get sectionInfo;

  /// No description provided for @resetInput.
  ///
  /// In ko, this message translates to:
  /// **'입력 초기화'**
  String get resetInput;

  /// No description provided for @resetSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'레인 1 · 랩 1 · 90초'**
  String get resetSubtitle;

  /// No description provided for @resetButton.
  ///
  /// In ko, this message translates to:
  /// **'초기화'**
  String get resetButton;

  /// No description provided for @resetDialogTitle.
  ///
  /// In ko, this message translates to:
  /// **'입력 초기화'**
  String get resetDialogTitle;

  /// No description provided for @resetDialogMessage.
  ///
  /// In ko, this message translates to:
  /// **'레인 1, 랩 카운트 1, 목표 시간 90초로 되돌립니다.'**
  String get resetDialogMessage;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @languageKorean.
  ///
  /// In ko, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// No description provided for @languageKoreanSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'Korean'**
  String get languageKoreanSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In ko, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'영어'**
  String get languageEnglishSubtitle;

  /// No description provided for @aboutMe.
  ///
  /// In ko, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @aboutMeSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'개발자 정보'**
  String get aboutMeSubtitle;

  /// No description provided for @devVersion.
  ///
  /// In ko, this message translates to:
  /// **'개발 버전 v{version} ({build})'**
  String devVersion(String version, int build);

  /// No description provided for @resetSuccess.
  ///
  /// In ko, this message translates to:
  /// **'입력값이 초기화되었습니다.'**
  String get resetSuccess;

  /// No description provided for @maxSecondsNotice.
  ///
  /// In ko, this message translates to:
  /// **'목표 시간은 최대 3600초(60분)까지 설정할 수 있습니다.'**
  String get maxSecondsNotice;

  /// No description provided for @durationSecondsOnly.
  ///
  /// In ko, this message translates to:
  /// **'{seconds}초'**
  String durationSecondsOnly(int seconds);

  /// No description provided for @durationMinutesOnly.
  ///
  /// In ko, this message translates to:
  /// **'{minutes}분'**
  String durationMinutesOnly(int minutes);

  /// No description provided for @durationMinutesSeconds.
  ///
  /// In ko, this message translates to:
  /// **'{minutes}분 {seconds}초'**
  String durationMinutesSeconds(int minutes, int seconds);

  /// No description provided for @developer.
  ///
  /// In ko, this message translates to:
  /// **'개발자'**
  String get developer;

  /// No description provided for @intro.
  ///
  /// In ko, this message translates to:
  /// **'소개'**
  String get intro;

  /// No description provided for @threads.
  ///
  /// In ko, this message translates to:
  /// **'Threads'**
  String get threads;

  /// No description provided for @threadsHandle.
  ///
  /// In ko, this message translates to:
  /// **'@{username}'**
  String threadsHandle(String username);

  /// No description provided for @usedLibraries.
  ///
  /// In ko, this message translates to:
  /// **'사용 라이브러리'**
  String get usedLibraries;

  /// No description provided for @developerBio.
  ///
  /// In ko, this message translates to:
  /// **'“트랙에서 90초로 뛰면,\n이게 몇 분 페이스일까?”\n\n러닝을 하며 한 번쯤 고민했던 질문에서\n이 앱이 시작되었습니다.\n\n레인에 따라 달라지는 거리까지 반영해\n보다 정확한 페이스를 제공합니다.\n\n복잡함은 줄이고,\n필요한 기능만 담았습니다.\n\n더 집중된 훈련을 위해,\n트랙 페이스 계산기.'**
  String get developerBio;

  /// No description provided for @linkOpenFailed.
  ///
  /// In ko, this message translates to:
  /// **'링크를 열 수 없습니다.'**
  String get linkOpenFailed;

  /// No description provided for @copyright.
  ///
  /// In ko, this message translates to:
  /// **'© 2026 트랙 페이스 계산기'**
  String get copyright;

  /// No description provided for @versionBuild.
  ///
  /// In ko, this message translates to:
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
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
