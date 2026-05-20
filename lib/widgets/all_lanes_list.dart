import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../models/lane_pace_result.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// 전 레인 페이스 그리드 (4×2).
class AllLanesList extends StatelessWidget {
  const AllLanesList({
    super.key,
    required this.results,
    required this.selectedLane,
  });

  final List<LanePaceResult> results;
  final int selectedLane;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cardWhite.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: AppColors.textLabel.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.xs + 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.allLanesPace,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: 1.75,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                final isSelected = result.lane == selectedLane;
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.highlightBg
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(
                            color: AppColors.primary.withValues(alpha: 0.6),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.laneLabel(result.lane),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.85)
                              : AppColors.textMuted,
                        ),
                      ),
                      Text(
                        result.displayPace.replaceAll('/km', ''),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
