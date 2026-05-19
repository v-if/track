import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../config/app_config.dart';
import '../theme/app_colors.dart';

/// 앱 아이콘·이름·버전 브랜딩 블록.
class AppBranding extends StatelessWidget {
  const AppBranding({
    super.key,
    this.iconSize = 56,
    this.showVersion = true,
    this.compact = false,
  });

  final double iconSize;
  final bool showVersion;
  final bool compact;

  static const appIconAsset = 'assets/images/icon3.png';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titleSize = compact ? 14.0 : 20.0;
    final titleWeight = compact ? FontWeight.w600 : FontWeight.w800;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(iconSize * 0.22),
          child: Image.asset(
            appIconAsset,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(iconSize * 0.22),
              ),
              child: Icon(
                Icons.directions_run,
                size: iconSize * 0.55,
                color: AppColors.textOnPrimary,
              ),
            ),
          ),
        ),
        SizedBox(height: compact ? 8 : 16),
        Text(
          l10n.appTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: titleWeight,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        if (showVersion) ...[
          const SizedBox(height: 4),
          Text(
            compact
                ? l10n.devVersion(AppConfig.appVersion, AppConfig.buildNumber)
                : l10n.versionBuild(
                    AppConfig.appVersion,
                    AppConfig.buildNumber,
                  ),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textLabel,
            ),
          ),
        ],
      ],
    );
  }
}

/// 로딩·스플래시용 브랜딩.
class AppBrandingLoader extends StatelessWidget {
  const AppBrandingLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBranding(iconSize: 72, showVersion: false),
        const SizedBox(height: 28),
        const SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2.5,
          ),
        ),
      ],
    );
  }
}
