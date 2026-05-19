/// About 화면에 표시할 주요 라이브러리 (기능 중심).
class AppLibrary {
  const AppLibrary(this.name, this.version);

  final String name;
  final String version;
}

/// `flutter --version` 기준으로 Flutter 버전을 맞춰 주세요.
const kAppLibraries = <AppLibrary>[
  AppLibrary('Flutter', '3.41.9'),
  AppLibrary('flutter_localizations', 'SDK'),
  AppLibrary('intl', '0.20.2'),
  AppLibrary('shared_preferences', '2.5.5'),
  AppLibrary('url_launcher', '6.3.2'),
];
