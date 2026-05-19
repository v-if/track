class LanePaceResult {
  const LanePaceResult({
    required this.lane,
    required this.paceSecondsPerKm,
    required this.displayPace,
  });

  final int lane;
  final int paceSecondsPerKm;
  final String displayPace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanePaceResult &&
          lane == other.lane &&
          paceSecondsPerKm == other.paceSecondsPerKm &&
          displayPace == other.displayPace;

  @override
  int get hashCode => Object.hash(lane, paceSecondsPerKm, displayPace);
}
