import '../data/lane_distances.dart';
import '../models/calculation_output.dart';
import '../models/lane_pace_result.dart';
import '../models/training_input.dart';

class PaceCalculator {
  PaceCalculator._();

  static int paceSecondsPerKm({
    required int lane,
    required int laps,
    required int seconds,
  }) {
    final distance = laneDistancesMeters[lane];
    if (distance == null) {
      throw ArgumentError.value(lane, 'lane', 'Lane must be between 1 and 8.');
    }
    if (laps < minLaps || laps > maxLaps) {
      throw ArgumentError.value(laps, 'laps', 'Laps must be between 1 and 20.');
    }
    if (seconds < minSeconds || seconds > maxSeconds) {
      throw ArgumentError.value(
        seconds,
        'seconds',
        'Seconds must be between 1 and 3600.',
      );
    }

    final totalMeters = distance * laps;
    return (seconds * 1000 / totalMeters).round();
  }

  static String formatPace(int paceSecondsPerKm) {
    final minutes = paceSecondsPerKm ~/ 60;
    final seconds = paceSecondsPerKm % 60;
    final paddedSeconds = seconds.toString().padLeft(2, '0');
    return '$minutes:$paddedSeconds/km';
  }

  static LanePaceResult resultForLane({
    required int lane,
    required int laps,
    required int seconds,
  }) {
    final pace = paceSecondsPerKm(lane: lane, laps: laps, seconds: seconds);
    return LanePaceResult(
      lane: lane,
      paceSecondsPerKm: pace,
      displayPace: formatPace(pace),
    );
  }

  static CalculationOutput calculateAll(TrainingInput input) {
    if (!input.isValid) {
      throw ArgumentError('Invalid training input: $input');
    }

    final allLanes = List<LanePaceResult>.generate(
      maxLane,
      (index) => resultForLane(
        lane: index + 1,
        laps: input.laps,
        seconds: input.seconds,
      ),
    );

    return CalculationOutput(
      selected: allLanes[input.lane - 1],
      allLanes: allLanes,
    );
  }
}
