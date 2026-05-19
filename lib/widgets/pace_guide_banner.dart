import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../theme/app_colors.dart';

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
        color: AppColors.guideBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.paceGuideTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                message,
                key: ValueKey<String>(message),
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
