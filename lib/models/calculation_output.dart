import 'lane_pace_result.dart';

class CalculationOutput {
  const CalculationOutput({
    required this.selected,
    required this.allLanes,
  });

  final LanePaceResult selected;
  final List<LanePaceResult> allLanes;
}
