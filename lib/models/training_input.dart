import '../data/lane_distances.dart';

class TrainingInput {
  const TrainingInput({
    required this.lane,
    required this.laps,
    required this.seconds,
  });

  /// 초기화 기본값: 1레인 · 1랩 · 90초
  static const TrainingInput initial =
      TrainingInput(lane: 1, laps: 1, seconds: 90);

  final int lane;
  final int laps;
  final int seconds;

  bool get isValid =>
      lane >= minLane &&
      lane <= maxLane &&
      laps >= minLaps &&
      laps <= maxLaps &&
      seconds >= minSeconds &&
      seconds <= maxSeconds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingInput &&
          lane == other.lane &&
          laps == other.laps &&
          seconds == other.seconds;

  @override
  int get hashCode => Object.hash(lane, laps, seconds);
}
