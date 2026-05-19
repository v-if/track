/// 앱 전역 설정 (출시 전 URL 등 확인).
abstract final class AppConfig {
  /// 개인정보처리방침 — 네이버 블로그 URL로 교체.
  static const String privacyPolicyUrl = 'https://blog.naver.com/placeholder';

  static const String appVersion = '1.0.0';
  static const int buildNumber = 2;

  static const String developerName = 'Taekyu Park';
  static const String threadsUsername = 'easyrun8';
  static const String threadsProfileUrl = 'https://www.threads.net/@easyrun8';
}
