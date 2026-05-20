// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Track Pace Calculator';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get selectLane => 'Select lane';

  @override
  String get lapCount => 'Lap count';

  @override
  String get lapUnit => ' laps';

  @override
  String get goalTime => 'Goal time';

  @override
  String get secondsUnit => ' sec';

  @override
  String get allLanesPace => 'Pace by lane';

  @override
  String laneLabel(int lane) {
    return 'Lane $lane';
  }

  @override
  String get paceGuideTitle => 'Pace guide';

  @override
  String paceGuideMessage(int seconds, int laps, int lane) {
    return 'This pace is the per-km pace when you run $laps lap(s) on lane $lane in $seconds seconds.';
  }

  @override
  String resultSubtitle(int lane, int laps, int seconds) {
    return 'Lane $lane · $laps lap(s) · ${seconds}s';
  }

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionLanguage => 'Language';

  @override
  String get sectionInfo => 'Info';

  @override
  String get resetInput => 'Reset input';

  @override
  String get resetSubtitle => 'Lane 1 · 1 lap · 90 sec';

  @override
  String get resetButton => 'Reset';

  @override
  String get resetDialogTitle => 'Reset input';

  @override
  String get resetDialogMessage => 'Reset to lane 1, 1 lap, and 90 seconds.';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get directEditInvalid => 'Enter a valid number';

  @override
  String directEditRange(int min, int max) {
    return 'Enter a value between $min and $max seconds';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishSubtitle => 'Default';

  @override
  String get languageKorean => '한국어';

  @override
  String get languageKoreanSubtitle => 'Korean';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageJapaneseSubtitle => 'Japanese';

  @override
  String get languageChinese => '中文';

  @override
  String get languageChineseSubtitle => 'Chinese';

  @override
  String get aboutMe => 'About me';

  @override
  String get aboutMeSubtitle => 'Developer info';

  @override
  String devVersion(String version, int build) {
    return 'Dev version v$version ($build)';
  }

  @override
  String get resetSuccess => 'Input has been reset.';

  @override
  String get maxSecondsNotice =>
      'Goal time can be set up to 3600 seconds (60 minutes).';

  @override
  String durationSecondsOnly(int seconds) {
    return '${seconds}s';
  }

  @override
  String durationMinutesOnly(int minutes) {
    return '$minutes min';
  }

  @override
  String durationMinutesSeconds(int minutes, int seconds) {
    return '$minutes min $seconds sec';
  }

  @override
  String get developer => 'Developer';

  @override
  String get intro => 'About';

  @override
  String get threads => 'Threads';

  @override
  String threadsHandle(String username) {
    return '@$username';
  }

  @override
  String get usedLibraries => 'Libraries used';

  @override
  String get developerBio =>
      '\"If I run 90 seconds on the track,\nwhat pace per km is that?\"\n\nThis app started from a question\nrunners ask themselves at least once.\n\nWe factor in lane distance differences\nto deliver a more accurate pace.\n\nLess complexity—\nonly what you need.\n\nFor more focused training:\nTrack Pace Calculator.';

  @override
  String get linkOpenFailed => 'Could not open the link.';

  @override
  String get copyright => '© 2026 Track Pace Calculator';

  @override
  String versionBuild(String version, int build) {
    return 'v$version (build $build)';
  }
}
