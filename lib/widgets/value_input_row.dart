import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'scale_tap.dart';

/// 바퀴 수 / 목표 시간 공통 입력 행.
class ValueInputRow extends StatelessWidget {
  const ValueInputRow({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
    this.subtitle,
  });

  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;
  final String? subtitle;

  static const double _baseHeight = 72;
  static const double _withSubtitleHeight = 88;

  double get _height => subtitle != null ? _withSubtitleHeight : _baseHeight;

  @override
  Widget build(BuildContext context) {
    final canDecrease = value - step >= min;
    final canIncrease = value + step <= max;

    return SizedBox(
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _RoundButton(
                icon: Icons.remove,
                enabled: canDecrease,
                onTap: () => onChanged(value - step),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textLabel,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$value$unit',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLabel,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _RoundButton(
                icon: Icons.add,
                enabled: canIncrease,
                onTap: () => onChanged(value + step),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      enabled: enabled,
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primary : AppColors.textLabel.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(22),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(icon, color: AppColors.textOnPrimary, size: 22),
      ),
    );
  }
}
