// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'トラックペース計算機';

  @override
  String get settings => '設定';

  @override
  String get settingsTooltip => '設定';

  @override
  String get selectLane => 'レーン選択';

  @override
  String get lapCount => 'ラップ数';

  @override
  String get lapUnit => '周';

  @override
  String get goalTime => '目標時間';

  @override
  String get secondsUnit => '秒';

  @override
  String get allLanesPace => 'レーン別ペース表';

  @override
  String laneLabel(int lane) {
    return 'レーン$lane';
  }

  @override
  String get paceGuideTitle => 'ペースガイド';

  @override
  String paceGuideMessage(int seconds, int laps, int lane) {
    return 'このペースは、レーン$laneで$laps周を$seconds秒で走ったときの1kmあたりのペースです。';
  }

  @override
  String resultSubtitle(int lane, int laps, int seconds) {
    return 'レーン$lane · $laps周 · $seconds秒';
  }

  @override
  String get sectionGeneral => '一般';

  @override
  String get sectionLanguage => '言語';

  @override
  String get sectionInfo => '情報';

  @override
  String get resetInput => '入力をリセット';

  @override
  String get resetSubtitle => 'レーン1 · 1周 · 90秒';

  @override
  String get resetButton => 'リセット';

  @override
  String get resetDialogTitle => '入力をリセット';

  @override
  String get resetDialogMessage => 'レーン1、ラップ1、目標時間90秒に戻します。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get directEditInvalid => '有効な数字を入力してください';

  @override
  String directEditRange(int min, int max) {
    return '$min〜$max秒の範囲で入力してください';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishSubtitle => 'デフォルト';

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
  String get aboutMeSubtitle => '開発者情報';

  @override
  String devVersion(String version, int build) {
    return '開発版 v$version ($build)';
  }

  @override
  String get resetSuccess => '入力がリセットされました。';

  @override
  String get maxSecondsNotice => '目標時間は最大3600秒（60分）まで設定できます。';

  @override
  String durationSecondsOnly(int seconds) {
    return '$seconds秒';
  }

  @override
  String durationMinutesOnly(int minutes) {
    return '$minutes分';
  }

  @override
  String durationMinutesSeconds(int minutes, int seconds) {
    return '$minutes分$seconds秒';
  }

  @override
  String get developer => '開発者';

  @override
  String get intro => '紹介';

  @override
  String get threads => 'Threads';

  @override
  String threadsHandle(String username) {
    return '@$username';
  }

  @override
  String get usedLibraries => '使用ライブラリ';

  @override
  String get developerBio =>
      '「トラックで90秒走ると、\nこれは何分ペース？」\n\nランニング中に一度は考えたことがある\nその疑問から、このアプリは始まりました。\n\nレーンごとに異なる距離も反映し、\nより正確なペースを提供します。\n\n複雑さを減らし、\n必要な機能だけを搭載しました。\n\nより集中したトレーニングのために、\nトラックペース計算機。';

  @override
  String get linkOpenFailed => 'リンクを開けませんでした。';

  @override
  String get copyright => '© 2026 Track Pace Calculator';

  @override
  String versionBuild(String version, int build) {
    return 'v$version (build $build)';
  }
}
