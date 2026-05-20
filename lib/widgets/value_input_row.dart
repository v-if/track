import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track/l10n/app_localizations.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'step_hold_button.dart';

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
    this.allowDirectEdit = false,
  });

  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;
  final String? subtitle;
  final bool allowDirectEdit;

  static const double _baseHeight = 72;
  static const double _withSubtitleHeight = 88;

  double get _height => subtitle != null ? _withSubtitleHeight : _baseHeight;

  Future<void> _showDirectEditDialog(BuildContext context) async {
    final controller = TextEditingController(text: '$value');
    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return _DirectEditDialog(
          title: label,
          controller: controller,
          min: min,
          max: max,
        );
      },
    );
    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canDecrease = value > min;
    final canIncrease = value < max;

    return SizedBox(
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            children: [
              StepHoldButton(
                icon: Icons.remove,
                enabled: canDecrease,
                onStep: (amount) {
                  final next = (value - amount).clamp(min, max);
                  if (next != value) {
                    onChanged(next);
                  }
                },
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: allowDirectEdit
                        ? () => _showDirectEditDialog(context)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLabel,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 120),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 0.96, end: 1)
                                    .animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            '$value$unit',
                            key: ValueKey<int>(value),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              StepHoldButton(
                icon: Icons.add,
                enabled: canIncrease,
                onStep: (amount) {
                  final next = (value + amount).clamp(min, max);
                  if (next != value) {
                    onChanged(next);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DirectEditDialog extends StatefulWidget {
  const _DirectEditDialog({
    required this.title,
    required this.controller,
    required this.min,
    required this.max,
  });

  final String title;
  final TextEditingController controller;
  final int min;
  final int max;

  @override
  State<_DirectEditDialog> createState() => _DirectEditDialogState();
}

class _DirectEditDialogState extends State<_DirectEditDialog> {
  String? _error;

  void _submit() {
    final parsed = int.tryParse(widget.controller.text.trim());
    if (parsed == null) {
      setState(() => _error = 'invalid');
      return;
    }
    if (parsed < widget.min || parsed > widget.max) {
      setState(() => _error = 'range');
      return;
    }
    Navigator.pop(context, parsed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autofocus: true,
        decoration: InputDecoration(
          suffixText: l10n.secondsUnit.trim(),
          errorText: _error == 'range'
              ? l10n.directEditRange(widget.min, widget.max)
              : _error != null
                  ? l10n.directEditInvalid
                  : null,
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}
