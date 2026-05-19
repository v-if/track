import 'package:flutter/material.dart';

import '../data/lane_distances.dart';
import '../theme/app_colors.dart';
import 'scale_tap.dart';

class LaneSelector extends StatelessWidget {
  const LaneSelector({
    super.key,
    required this.selectedLane,
    required this.onLaneSelected,
  });

  final int selectedLane;
  final ValueChanged<int> onLaneSelected;

  static const double itemHeight = 48;
  static const double _outerBorderWidth = 3.0;
  static const double _dividerWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    // 흰색 Container + padding → 외곽 라인이 항상 보이도록 처리
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textOnPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(_outerBorderWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: SizedBox(
          height: itemHeight,
          child: ColoredBox(
            color: AppColors.laneDefault,
            child: Row(
              children: List<Widget>.generate(maxLane, (index) {
                final lane = index + 1;
                return Expanded(
                  child: Row(
                    children: [
                      if (index > 0)
                        Container(
                          width: _dividerWidth,
                          color: AppColors.textOnPrimary,
                        ),
                      Expanded(
                        child: _LaneButton(
                          lane: lane,
                          isSelected: lane == selectedLane,
                          onTap: () => onLaneSelected(lane),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _LaneButton extends StatelessWidget {
  const _LaneButton({
    required this.lane,
    required this.isSelected,
    required this.onTap,
  });

  final int lane;
  final bool isSelected;
  final VoidCallback onTap;

  static const _textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 1,
  );

  double _underlineTop(double cellHeight) {
    const textHeight = 16.0;
    final textBottom = (cellHeight + textHeight) / 2;
    return textBottom + (cellHeight - textBottom) / 2;
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        isSelected ? AppColors.primary : AppColors.textOnPrimary;
    final underlineTop = _underlineTop(LaneSelector.itemHeight);

    return ScaleTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: LaneSelector.itemHeight,
        color: isSelected ? AppColors.cardWhite : AppColors.laneDefault,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '$lane',
              style: _textStyle.copyWith(color: textColor),
            ),
            if (isSelected)
              Positioned(
                top: underlineTop,
                left: 6,
                right: 6,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
