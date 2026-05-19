import 'package:flutter/widgets.dart';
import 'package:track/l10n/app_localizations.dart';

/// 초 → 로케일에 맞는 "2분 50초" / "2 min 50 sec" 형식.
String formatMinutesSeconds(BuildContext context, int totalSeconds) {
  final l10n = AppLocalizations.of(context);
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;

  if (minutes == 0) {
    return l10n.durationSecondsOnly(seconds);
  }
  if (seconds == 0) {
    return l10n.durationMinutesOnly(minutes);
  }
  return l10n.durationMinutesSeconds(minutes, seconds);
}

/// 바퀴 수 변경 시 목표 시간을 비례 조정.
int scaleSecondsForLaps({
  required int currentSeconds,
  required int oldLaps,
  required int newLaps,
  required int minSeconds,
  required int maxSeconds,
}) {
  if (oldLaps <= 0) {
    return currentSeconds.clamp(minSeconds, maxSeconds);
  }
  final scaled = (currentSeconds * newLaps / oldLaps).round();
  return scaled.clamp(minSeconds, maxSeconds);
}
