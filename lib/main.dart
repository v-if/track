import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/home_screen.dart';
import 'services/locale_controller.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleController.instance.initialize();
  runApp(const TrackPaceApp());
}

class TrackPaceApp extends StatefulWidget {
  const TrackPaceApp({super.key});

  @override
  State<TrackPaceApp> createState() => _TrackPaceAppState();
}

class _TrackPaceAppState extends State<TrackPaceApp> {
  final _localeController = LocaleController.instance;

  @override
  void initState() {
    super.initState();
    _localeController.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    _localeController.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      locale: _localeController.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
