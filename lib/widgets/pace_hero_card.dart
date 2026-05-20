import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class PaceHeroCard extends StatelessWidget {
  const PaceHeroCard({
    super.key,
    required this.paceText,
    required this.subtitle,
  });

  final String paceText;
  final String subtitle;

  static const double height = 152;
  static const _backgroundAsset = 'assets/images/track_page_result2.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.heroRadius),
          image: const DecorationImage(
            image: AssetImage(_backgroundAsset),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.heroRadius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.97, end: 1).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  paceText,
                  key: ValueKey<String>(paceText),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textOnPrimary,
                    letterSpacing: -1,
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: Text(
                  subtitle,
                  key: ValueKey<String>(subtitle),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textOnPrimary.withValues(alpha: 0.88),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `3:45/km` → `3:45 /km`
String heroPaceFromDisplay(String displayPace) {
  if (displayPace.endsWith('/km')) {
    return '${displayPace.substring(0, displayPace.length - 3)} /km';
  }
  return displayPace;
}
