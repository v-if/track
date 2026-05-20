// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '트랙 페이스 계산기';

  @override
  String get settings => '설정';

  @override
  String get settingsTooltip => '설정';

  @override
  String get selectLane => '레인 선택';

  @override
  String get lapCount => '랩 카운트';

  @override
  String get lapUnit => '랩';

  @override
  String get goalTime => '목표 시간';

  @override
  String get secondsUnit => '초';

  @override
  String get allLanesPace => '레인별 페이스표';

  @override
  String laneLabel(int lane) {
    return '$lane레인';
  }

  @override
  String get paceGuideTitle => '페이스 가이드';

  @override
  String paceGuideMessage(int seconds, int laps, int lane) {
    return '이 페이스는 목표시간 $seconds초로 $laps랩($lane레인)를 뛰었을 때의 1km 기준 페이스 입니다.';
  }

  @override
  String resultSubtitle(int lane, int laps, int seconds) {
    return '$lane레인 · $laps랩 · $seconds초';
  }

  @override
  String get sectionGeneral => '일반';

  @override
  String get sectionLanguage => '언어';

  @override
  String get sectionInfo => '정보';

  @override
  String get resetInput => '입력 초기화';

  @override
  String get resetSubtitle => '레인 1 · 랩 1 · 90초';

  @override
  String get resetButton => '초기화';

  @override
  String get resetDialogTitle => '입력 초기화';

  @override
  String get resetDialogMessage => '레인 1, 랩 카운트 1, 목표 시간 90초로 되돌립니다.';

  @override
  String get cancel => '취소';

  @override
  String get ok => '확인';

  @override
  String get directEditInvalid => '숫자를 입력하세요';

  @override
  String directEditRange(int min, int max) {
    return '$min–$max초 범위로 입력하세요';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishSubtitle => '기본';

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
  String get aboutMeSubtitle => '개발자 정보';

  @override
  String devVersion(String version, int build) {
    return '개발 버전 v$version ($build)';
  }

  @override
  String get resetSuccess => '입력값이 초기화되었습니다.';

  @override
  String get maxSecondsNotice => '목표 시간은 최대 3600초(60분)까지 설정할 수 있습니다.';

  @override
  String durationSecondsOnly(int seconds) {
    return '$seconds초';
  }

  @override
  String durationMinutesOnly(int minutes) {
    return '$minutes분';
  }

  @override
  String durationMinutesSeconds(int minutes, int seconds) {
    return '$minutes분 $seconds초';
  }

  @override
  String get developer => '개발자';

  @override
  String get intro => '소개';

  @override
  String get threads => 'Threads';

  @override
  String threadsHandle(String username) {
    return '@$username';
  }

  @override
  String get usedLibraries => '사용 라이브러리';

  @override
  String get developerBio =>
      '“트랙에서 90초로 뛰면,\n이게 몇 분 페이스일까?”\n\n러닝을 하며 한 번쯤 고민했던 질문에서\n이 앱이 시작되었습니다.\n\n레인에 따라 달라지는 거리까지 반영해\n보다 정확한 페이스를 제공합니다.\n\n복잡함은 줄이고,\n필요한 기능만 담았습니다.\n\n더 집중된 훈련을 위해,\n트랙 페이스 계산기.';

  @override
  String get linkOpenFailed => '링크를 열 수 없습니다.';

  @override
  String get copyright => '© 2026 트랙 페이스 계산기';

  @override
  String versionBuild(String version, int build) {
    return 'v$version (build $build)';
  }
}
