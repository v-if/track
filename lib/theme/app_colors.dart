import 'package:flutter/material.dart';

abstract final class AppColors {
  // 브랜드
  static const primary = Color(0xFFD65A1F);
  static const primaryDark = Color(0xFFC94E1F);
  static const resultGreen = Color(0xFF2F6B4F);

  // 레인
  static const laneDefault = Color(0xFFE07A3F);
  static const laneContainerOverlay = Color(0x1AFFFFFF);

  // 텍스트
  static const textPrimary = Color(0xFF222222);
  static const textLabel = Color(0xFF777777);
  static const textMuted = Color(0xFF666666);
  static const textOnPrimary = Color(0xFFFFFFFF);

  // 서피스
  static const scaffoldBg = Color(0xFFF2F2F2);
  static const cardWhite = Color(0xFFFFFFFF);
  static const guideBg = Color(0xFFE8E8E8);

  // 레거시 호환
  static const trackRed = primary;
  static const infieldGreen = resultGreen;
  static Color highlightBg = primary.withValues(alpha: 0.12);
}
