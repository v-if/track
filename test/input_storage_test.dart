import 'package:flutter_test/flutter_test.dart';
import 'package:track/models/training_input.dart';
import 'package:track/services/input_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('InputStorage', () {
    test('save and load round-trip', () async {
      const input = TrainingInput(lane: 3, laps: 2, seconds: 180);
      await InputStorage.save(input);

      final loaded = await InputStorage.load();
      expect(loaded, input);
    });

    test('load returns null when empty', () async {
      final loaded = await InputStorage.load();
      expect(loaded, isNull);
    });

    test('load returns null for invalid stored values', () async {
      SharedPreferences.setMockInitialValues({
        InputStorage.keyLane: 99,
        InputStorage.keyLaps: 1,
        InputStorage.keySeconds: 90,
      });

      final loaded = await InputStorage.load();
      expect(loaded, isNull);
    });

    test('clear removes saved values', () async {
      await InputStorage.save(
        const TrainingInput(lane: 1, laps: 1, seconds: 90),
      );
      await InputStorage.clear();

      final loaded = await InputStorage.load();
      expect(loaded, isNull);
    });

    test('resetToDefault saves initial values', () async {
      await InputStorage.save(
        const TrainingInput(lane: 5, laps: 3, seconds: 200),
      );

      final reset = await InputStorage.resetToDefault();
      expect(reset, TrainingInput.initial);

      final loaded = await InputStorage.load();
      expect(loaded, TrainingInput.initial);
    });
  });
}
