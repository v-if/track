import 'package:test/test.dart';
import 'package:track/models/training_input.dart';
import 'package:track/services/pace_calculator.dart';

void main() {
  group('formatPace', () {
    test('formats minutes and zero-padded seconds', () {
      expect(PaceCalculator.formatPace(225), '3:45/km');
      expect(PaceCalculator.formatPace(150), '2:30/km');
      expect(PaceCalculator.formatPace(90), '1:30/km');
      expect(PaceCalculator.formatPace(59), '0:59/km');
    });
  });

  group('paceSecondsPerKm', () {
    final cases = <({int lane, int laps, int sec, int pace})>[
      (lane: 1, laps: 1, sec: 90, pace: 225),
      (lane: 2, laps: 1, sec: 90, pace: 221),
      (lane: 8, laps: 1, sec: 90, pace: 198),
      (lane: 1, laps: 2, sec: 180, pace: 225),
      (lane: 1, laps: 1, sec: 60, pace: 150),
      (lane: 8, laps: 20, sec: 3600, pace: 397),
    ];

    for (final c in cases) {
      test('lane ${c.lane}, ${c.laps} laps, ${c.sec}s → ${c.pace}s/km', () {
        expect(
          PaceCalculator.paceSecondsPerKm(
            lane: c.lane,
            laps: c.laps,
            seconds: c.sec,
          ),
          c.pace,
        );
      });
    }

    test('throws for invalid lane', () {
      expect(
        () => PaceCalculator.paceSecondsPerKm(lane: 0, laps: 1, seconds: 90),
        throwsArgumentError,
      );
    });
  });

  group('golden display pace', () {
    final cases = <({int lane, int laps, int sec, String display})>[
      (lane: 1, laps: 1, sec: 90, display: '3:45/km'),
      (lane: 2, laps: 1, sec: 90, display: '3:41/km'),
      (lane: 8, laps: 1, sec: 90, display: '3:18/km'),
      (lane: 1, laps: 2, sec: 180, display: '3:45/km'),
      (lane: 1, laps: 1, sec: 60, display: '2:30/km'),
      (lane: 8, laps: 20, sec: 3600, display: '6:37/km'),
    ];

    for (final c in cases) {
      test('lane ${c.lane} → ${c.display}', () {
        final pace = PaceCalculator.paceSecondsPerKm(
          lane: c.lane,
          laps: c.laps,
          seconds: c.sec,
        );
        expect(PaceCalculator.formatPace(pace), c.display);
      });
    }
  });

  group('calculateAll', () {
    test('returns 8 lane results in order', () {
      const input = TrainingInput(lane: 3, laps: 1, seconds: 90);
      final output = PaceCalculator.calculateAll(input);

      expect(output.allLanes, hasLength(8));
      expect(output.allLanes.map((r) => r.lane).toList(), [1, 2, 3, 4, 5, 6, 7, 8]);
      expect(output.selected.lane, 3);
      expect(output.selected.displayPace, '3:36/km');
    });

    test('throws for invalid input', () {
      const input = TrainingInput(lane: 9, laps: 1, seconds: 90);
      expect(() => PaceCalculator.calculateAll(input), throwsArgumentError);
    });
  });

  group('monotonic pace by lane', () {
    test('outer lanes are faster for same laps and time', () {
      const input = TrainingInput(lane: 1, laps: 1, seconds: 90);
      final output = PaceCalculator.calculateAll(input);

      final lane1 = output.allLanes.first.paceSecondsPerKm;
      final lane8 = output.allLanes.last.paceSecondsPerKm;

      expect(lane8, lessThan(lane1));
    });
  });
}
