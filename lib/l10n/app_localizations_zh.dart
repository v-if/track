// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '跑道配速计算器';

  @override
  String get settings => '设置';

  @override
  String get settingsTooltip => '设置';

  @override
  String get selectLane => '选择跑道';

  @override
  String get lapCount => '圈数';

  @override
  String get lapUnit => '圈';

  @override
  String get goalTime => '目标时间';

  @override
  String get secondsUnit => '秒';

  @override
  String get allLanesPace => '各跑道配速表';

  @override
  String laneLabel(int lane) {
    return '$lane道';
  }

  @override
  String get paceGuideTitle => '配速说明';

  @override
  String paceGuideMessage(int seconds, int laps, int lane) {
    return '此配速为在$lane道以$seconds秒跑完$laps圈时的每公里配速。';
  }

  @override
  String resultSubtitle(int lane, int laps, int seconds) {
    return '$lane道 · $laps圈 · $seconds秒';
  }

  @override
  String get sectionGeneral => '通用';

  @override
  String get sectionLanguage => '语言';

  @override
  String get sectionInfo => '信息';

  @override
  String get resetInput => '重置输入';

  @override
  String get resetSubtitle => '1道 · 1圈 · 90秒';

  @override
  String get resetButton => '重置';

  @override
  String get resetDialogTitle => '重置输入';

  @override
  String get resetDialogMessage => '将重置为1道、1圈、目标时间90秒。';

  @override
  String get cancel => '取消';

  @override
  String get ok => '确定';

  @override
  String get directEditInvalid => '请输入有效数字';

  @override
  String directEditRange(int min, int max) {
    return '请输入 $min–$max 秒范围内的数值';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishSubtitle => '默认';

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
  String get aboutMeSubtitle => '开发者信息';

  @override
  String devVersion(String version, int build) {
    return '开发版 v$version ($build)';
  }

  @override
  String get resetSuccess => '输入已重置。';

  @override
  String get maxSecondsNotice => '目标时间最多可设置为3600秒（60分钟）。';

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
  String get developer => '开发者';

  @override
  String get intro => '介绍';

  @override
  String get threads => 'Threads';

  @override
  String threadsHandle(String username) {
    return '@$username';
  }

  @override
  String get usedLibraries => '使用的库';

  @override
  String get developerBio =>
      '「在跑道上跑90秒，\n这相当于多少配速？」\n\n跑步时每个人都曾想过的问题，\n正是这款应用的起点。\n\n我们计入不同跑道的距离差异，\n提供更准确的配速。\n\n减少复杂操作，\n只保留你需要的功能。\n\n为更专注的训练——\n跑道配速计算器。';

  @override
  String get linkOpenFailed => '无法打开链接。';

  @override
  String get copyright => '© 2026 Track Pace Calculator';

  @override
  String versionBuild(String version, int build) {
    return 'v$version (build $build)';
  }
}
