import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../services/input_storage.dart';
import '../services/locale_controller.dart';
import '../services/locale_storage.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
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

  List<({String label, String subtitle, String code, Future<void> Function() onSelect})>
      _languageOptions(AppLocalizations l10n) {
    return [
      (
        label: l10n.languageEnglish,
        subtitle: l10n.languageEnglishSubtitle,
        code: LocaleStorage.englishCode,
        onSelect: _localeController.setEnglish,
      ),
      (
        label: l10n.languageKorean,
        subtitle: l10n.languageKoreanSubtitle,
        code: LocaleStorage.koreanCode,
        onSelect: _localeController.setKorean,
      ),
      (
        label: l10n.languageJapanese,
        subtitle: l10n.languageJapaneseSubtitle,
        code: LocaleStorage.japaneseCode,
        onSelect: _localeController.setJapanese,
      ),
      (
        label: l10n.languageChinese,
        subtitle: l10n.languageChineseSubtitle,
        code: LocaleStorage.chineseCode,
        onSelect: _localeController.setChinese,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageOptions = _languageOptions(l10n);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: AppBarTitle(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          SettingsCard(
            title: l10n.sectionGeneral,
            children: [
              SettingsTile(
                icon: Icons.restart_alt,
                title: l10n.resetInput,
                subtitle: l10n.resetSubtitle,
                showChevron: false,
                trailing: TextButton(
                  onPressed: _showResetDialog,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textMuted,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 36),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    l10n.resetButton,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 4),
          SettingsCard(
            title: l10n.sectionLanguage,
            children: [
              for (var i = 0; i < languageOptions.length; i++)
                _LanguageOption(
                  label: languageOptions[i].label,
                  subtitle: languageOptions[i].subtitle,
                  selected: _localeController.isSelected(languageOptions[i].code),
                  onTap: () => languageOptions[i].onSelect(),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 4),
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
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: AppBranding(compact: true),
          ),
          const SizedBox(height: AppSpacing.md),
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
