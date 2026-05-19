import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../services/input_storage.dart';
import '../services/locale_controller.dart';
import '../services/locale_storage.dart';
import '../theme/app_colors.dart';
import '../widgets/app_branding.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/settings_card.dart';
import 'about_screen.dart';

/// 설정 화면.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
    if (mounted) {
      setState(() {});
    }
  }

  bool get _isKorean =>
      _localeController.locale.languageCode == LocaleStorage.koreanCode;

  Future<void> _showResetDialog() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.resetDialogTitle),
        content: Text(l10n.resetDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.resetButton),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    await InputStorage.resetToDefault();

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(true);
  }

  void _openAbout() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const AboutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: AppBarTitle(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SettingsCard(
            title: l10n.sectionGeneral,
            children: [
              SettingsTile(
                icon: Icons.restart_alt,
                title: l10n.resetInput,
                subtitle: l10n.resetSubtitle,
                showChevron: false,
                trailing: OutlinedButton(
                  onPressed: _showResetDialog,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: Text(l10n.resetButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SettingsCard(
            title: l10n.sectionLanguage,
            children: [
              _LanguageOption(
                label: l10n.languageKorean,
                subtitle: l10n.languageKoreanSubtitle,
                selected: _isKorean,
                onTap: _localeController.setKorean,
              ),
              _LanguageOption(
                label: l10n.languageEnglish,
                subtitle: l10n.languageEnglishSubtitle,
                selected: !_isKorean,
                onTap: _localeController.setEnglish,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SettingsCard(
            title: l10n.sectionInfo,
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: l10n.aboutMe,
                subtitle: l10n.aboutMeSubtitle,
                onTap: _openAbout,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: AppBranding(compact: true),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? AppColors.primary : AppColors.textLabel,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
