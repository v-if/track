import 'package:shared_preferences/shared_preferences.dart';

import '../models/training_input.dart';

/// 마지막 입력값 로컬 저장 (SharedPreferences).
class InputStorage {
  InputStorage._();

  static const String keyLane = 'last_lane';
  static const String keyLaps = 'last_laps';
  static const String keySeconds = 'last_seconds';

  static Future<TrainingInput?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final lane = prefs.getInt(keyLane);
    final laps = prefs.getInt(keyLaps);
    final seconds = prefs.getInt(keySeconds);

    if (lane == null || laps == null || seconds == null) {
      return null;
    }

    final input = TrainingInput(lane: lane, laps: laps, seconds: seconds);
    if (!input.isValid) {
      return null;
    }
    return input;
  }

  static Future<void> save(TrainingInput input) async {
    if (!input.isValid) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyLane, input.lane);
    await prefs.setInt(keyLaps, input.laps);
    await prefs.setInt(keySeconds, input.seconds);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyLane);
    await prefs.remove(keyLaps);
    await prefs.remove(keySeconds);
  }

  /// 기본값으로 저장 (초기화).
  static Future<TrainingInput> resetToDefault() async {
    await save(TrainingInput.initial);
    return TrainingInput.initial;
  }
}
