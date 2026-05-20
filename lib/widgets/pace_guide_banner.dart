import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class PaceGuideBanner extends StatelessWidget {
  const PaceGuideBanner({
    super.key,
    required this.lane,
    required this.laps,
    required this.seconds,
  });

  final int lane;
  final int laps;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final message = l10n.paceGuideMessage(seconds, laps, lane);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.guideBg.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs + 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.paceGuideTitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: Text(
                message,
                key: ValueKey<String>(message),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
