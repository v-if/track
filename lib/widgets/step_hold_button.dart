import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

/// 탭 ±1, 길게 누르면 100ms 간격 연속 변경, 1초 후 ±5 가속.
class StepHoldButton extends StatefulWidget {
  const StepHoldButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.onStep,
  });

  final IconData icon;
  final bool enabled;
  final ValueChanged<int> onStep;

  @override
  State<StepHoldButton> createState() => _StepHoldButtonState();
}

class _StepHoldButtonState extends State<StepHoldButton> {
  static const _repeatInterval = Duration(milliseconds: 100);
  static const _accelerateAfter = Duration(seconds: 1);
  static const _longPressDelay = Duration(milliseconds: 280);

  Timer? _repeatTimer;
  Timer? _longPressTimer;
  DateTime? _pressStarted;
  bool _isRepeating = false;
  bool _pressed = false;

  int get _currentStep {
    if (_pressStarted == null) {
      return 1;
    }
    final held = DateTime.now().difference(_pressStarted!);
    return held >= _accelerateAfter ? 5 : 1;
  }

  void _applyStep() {
    if (!widget.enabled) {
      return;
    }
    HapticFeedback.selectionClick();
    widget.onStep(_currentStep);
  }

  void _startRepeat() {
    if (!widget.enabled || _isRepeating) {
      return;
    }
    _isRepeating = true;
    _applyStep();
    _repeatTimer?.cancel();
    _repeatTimer = Timer.periodic(_repeatInterval, (_) => _applyStep());
  }

  void _stop({required bool applySingleTap}) {
    _longPressTimer?.cancel();
    _longPressTimer = null;
    _repeatTimer?.cancel();
    _repeatTimer = null;

    if (applySingleTap && !_isRepeating && widget.enabled) {
      widget.onStep(1);
      HapticFeedback.selectionClick();
    }

    _isRepeating = false;
    _pressStarted = null;
    if (_pressed) {
      setState(() => _pressed = false);
    }
  }

  @override
  void dispose() {
    _longPressTimer?.cancel();
    _repeatTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.enabled
          ? (_) {
              _pressStarted = DateTime.now();
              _isRepeating = false;
              setState(() => _pressed = true);
              _longPressTimer?.cancel();
              _longPressTimer = Timer(_longPressDelay, _startRepeat);
            }
          : null,
      onTapUp: widget.enabled ? (_) => _stop(applySingleTap: true) : null,
      onTapCancel: widget.enabled ? () => _stop(applySingleTap: false) : null,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: widget.enabled
                ? AppColors.primary
                : AppColors.textLabel.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(22),
            boxShadow: widget.enabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.28),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            widget.icon,
            color: AppColors.textOnPrimary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
