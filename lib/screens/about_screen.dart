import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../data/app_libraries.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/app_branding.dart';

/// 개발자 정보.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _openThreadsProfile(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri.parse(AppConfig.threadsProfileUrl);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.linkOpenFailed)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.linkOpenFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: AppBarTitle(l10n.aboutMe),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xs),
            AppBranding(iconSize: 88),
            const SizedBox(height: AppSpacing.md),
            _InfoCard(
              children: [
                _InfoRow(
                  label: l10n.developer,
                  value: AppConfig.developerName,
                ),
                const Divider(height: 24),
                _ThreadsRow(
                  label: l10n.threads,
                  handle: l10n.threadsHandle(AppConfig.threadsUsername),
                  onTap: () => _openThreadsProfile(context),
                ),
                const Divider(height: AppSpacing.md),
                _InfoRow(
                  label: l10n.intro,
                  value: l10n.developerBio,
                  isBio: true,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _InfoCard(
              children: [
                Text(
                  l10n.usedLibraries,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLabel,
                  ),
                ),
                const SizedBox(height: 12),
                ...kAppLibraries.map(
                  (library) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _LibraryRow(library: library),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.copyright,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textLabel.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isBio = false,
  });

  final String label;
  final String value;
  final bool isBio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textLabel,
          ),
        ),
        SizedBox(height: isBio ? AppSpacing.xs : 6),
        Text(
          value,
          style: TextStyle(
            fontSize: isBio ? 14 : 15,
            height: isBio ? 1.55 : 1.45,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ThreadsRow extends StatelessWidget {
  const _ThreadsRow({
    required this.label,
    required this.handle,
    required this.onTap,
  });

  final String label;
  final String handle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textLabel,
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Text(
                    handle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: AppColors.primary.withValues(alpha: 0.85),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LibraryRow extends StatelessWidget {
  const _LibraryRow({required this.library});

  final AppLibrary library;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            library.name,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Text(
          library.version,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textLabel,
          ),
        ),
      ],
    );
  }
}
