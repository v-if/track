/// IAAF 표준 400m 트랙 — 레인별 1바퀴 거리 (m).
const Map<int, double> laneDistancesMeters = <int, double>{
  1: 400.00,
  2: 407.67,
  3: 415.33,
  4: 423.00,
  5: 430.67,
  6: 438.33,
  7: 446.00,
  8: 453.67,
};

const int minLane = 1;
const int maxLane = 8;
const int minLaps = 1;
const int maxLaps = 20;
const int minSeconds = 1;
const int maxSeconds = 3600;
