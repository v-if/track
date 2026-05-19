# 러닝 트랙 페이스 계산기 — 기술·화면 명세

> 문서 버전: **1.0**  
> 작성일: 2026-05-18  
> 기준 요건: [`requirements.md`](./requirements.md) v1.0

---

## 1. 아키텍처 개요

```
lib/
├── main.dart                 # 앱 진입, 테마, HomeScreen
├── models/
│   ├── training_input.dart   # 레인, 바퀴, 초
│   └── lane_pace_result.dart # 레인별 페이스 결과
├── services/
│   ├── pace_calculator.dart  # 순수 계산 (단위 테스트 대상)
│   └── input_storage.dart    # SharedPreferences 래퍼
├── data/
│   ├── lane_distances.dart   # 8레인 거리 상수
│   └── presets.dart          # 프리셋 정의
└── screens/
    └── home_screen.dart      # 단일 화면 (MVP 전체 UI)
```

| 원칙 | 내용 |
|------|------|
| 상태 관리 | `StatefulWidget` + `setState` only |
| 네트워크 | 없음 |
| 외부 패키지 (예상) | `shared_preferences` (로컬 저장만) |
| 테스트 | `test/pace_calculator_test.dart` |

---

## 2. 화면 명세 — Home (단일 화면)

### 2.1 화면 구조 (세로 스크롤)

```
┌─────────────────────────────────┐
│ AppBar: 앱 이름 (추후 확정)        │
├─────────────────────────────────┤
│ [프리셋 칩 가로 스크롤]            │
├─────────────────────────────────┤
│ 섹션: 레인                        │
│ [1][2][3][4][5][6][7][8]  ← 가로   │
├─────────────────────────────────┤
│ 섹션: 바퀴 수                     │
│  [-]  [ 1 ]  [+]   (1~20)       │
├─────────────────────────────────┤
│ 섹션: 목표 시간 (초)               │
│  [-]  [ 90 ]  [+]   (1~3600)    │
│  또는 숫자 키패드 TextField        │
├─────────────────────────────────┤
│ ■ 선택 레인 페이스 (히어로)        │
│     3:45 /km                     │
│     3레인 · 1바퀴 · 90초          │
├─────────────────────────────────┤
│ 섹션: 전 레인 비교                 │
│  1레인  3:45/km                  │
│  2레인  3:40/km                  │
│ ▶3레인  3:36/km  ← 강조          │
│  ...                             │
│  8레인  3:18/km                  │
├─────────────────────────────────┤
│ (선택) 설정 링크: 개인정보처리방침   │
└─────────────────────────────────┘
```

### 2.2 동작

| 동작 | 규칙 |
|------|------|
| 입력 변경 | **즉시** `PaceCalculator` 재호출 → 히어로·목록 갱신 |
| 레인 선택 | 8개 `ChoiceChip` 또는 `SegmentedButton` 스타일 가로 배치 |
| 바퀴 ± | 최소 1, 최대 20, 경계에서 버튼 비활성 |
| 시간 ± | 최소 1, 최대 3600, 경계에서 버튼 비활성 |
| 시간 직접 입력 | `TextInputType.number`, 필터로 1~3600만 허용, 빈 값 시 결과 영역 placeholder |
| 앱 시작 | `InputStorage`에서 마지막 값 로드 후 계산 |
| 값 변경 후 | debounce 없음 (로컬 계산만) |

### 2.3 빈·무효 상태 UI

| 상태 | UI |
|------|-----|
| 시간 미입력 또는 0 | 히어로: `—` 또는 "목표 시간을 입력하세요" |
| 정상 | `M:SS/km` + 부제 "N레인 · X바퀴 · Y초" |

---

## 3. 컴포넌트 명세

### 3.1 LaneSelector (가로 8버튼)

| 속성 | 값 |
|------|-----|
| 레이아웃 | `Row` + `Expanded` × 8 또는 가로 스크롤 `ListView` |
| 선택 | `selectedLane` 1~8 |
| 스타일 (선택) | 트랙 레드 배경 + 흰 글자 |
| 스타일 (비선택) | 연한 회색 테두리 |

### 3.2 LapStepper

| 속성 | 값 |
|------|-----|
| 범위 | 1 ~ 20 |
| 기본 | 1 |
| UI | `-` / 숫자 / `+` |

### 3.3 TimeStepper (초)

| 속성 | 값 |
|------|-----|
| 범위 | 1 ~ 3600 |
| step | ±5 또는 ±1 (구현 시 ±5 권장 — 90초 조절 편의) |
| 표시 | 정수 + 단위 "초" |

### 3.4 PresetChips

| 속성 | 값 |
|------|-----|
| 레이아웃 | 가로 `ListView` of `ActionChip` |
| 탭 시 | `laps`, `seconds`만 변경 (레인은 유지) |
| 정의 | §5 프리셋 테이블 |

### 3.5 PaceHeroCard

| 속성 | 값 |
|------|-----|
| 내용 | 큰 글씨 `3:45/km`, 부제 입력 요약 |
| 배경 | 인필드 그린 계열 카드 |

### 3.6 AllLanesList

| 속성 | 값 |
|------|-----|
| 행 수 | 8 (레인 1~8 고정) |
| 열 | 레인 번호, 페이스 |
| 강조 | `selectedLane == row.lane` → `fontWeight.bold`, 좌측 악센트 바 또는 배경 tint |
| 정렬 | 레인 번호 오름차순 |

---

## 4. 데이터 모델

### 4.1 `TrainingInput`

```dart
class TrainingInput {
  final int lane;      // 1..8
  final int laps;      // 1..20
  final int seconds;   // 1..3600

  bool get isValid =>
      lane >= 1 && lane <= 8 &&
      laps >= 1 && laps <= 20 &&
      seconds >= 1 && seconds <= 3600;
}
```

### 4.2 `LanePaceResult`

```dart
class LanePaceResult {
  final int lane;
  final int paceSecondsPerKm;  // 내부: 초/km (반올림된 정수)
  final String displayPace;      // "3:45/km"
}
```

### 4.3 `CalculationOutput`

```dart
class CalculationOutput {
  final LanePaceResult selected;
  final List<LanePaceResult> allLanes; // length 8
}
```

### 4.4 로컬 저장 키 (`SharedPreferences`)

| 키 | 타입 | 설명 |
|----|------|------|
| `last_lane` | int | 1~8 |
| `last_laps` | int | 1~20 |
| `last_seconds` | int | 1~3600 |

저장 시점: 레인·바퀴·초 변경 시 (debounce 300ms 권장 — 디스크 I/O 최소화).

---

## 5. 프리셋 정의 (MVP)

| ID | 라벨 (UI) | 바퀴 | 시간(초) |
|----|-----------|------|----------|
| p1 | 1바퀴 60초 | 1 | 60 |
| p2 | 1바퀴 90초 | 1 | 90 |
| p3 | 1바퀴 120초 | 1 | 120 |
| p4 | 2바퀴 180초 | 2 | 180 |
| p5 | 2바퀴 240초 | 2 | 240 |

- 레인은 프리셋이 **변경하지 않음**
- 추후 v1.1에서 사용자 편집 가능 (Could)

---

## 6. 계산 검증 기대값

### 6.1 `PaceCalculator` API

```dart
class PaceCalculator {
  /// 단일 레인 페이스 (초/km 반올림 후 포맷)
  static int paceSecondsPerKm({
    required int lane,
    required int laps,
    required int seconds,
  });

  static String formatPace(int paceSecondsPerKm);
  // → "3:45/km"  (분 = pace ~/ 60, 초 = pace % 60, 초 2자리 패딩)

  static CalculationOutput calculateAll(TrainingInput input);
}
```

### 6.2 거리 상수

```dart
const laneDistancesMeters = <int, double>{
  1: 400.00,
  2: 407.67,
  3: 415.33,
  4: 423.00,
  5: 430.67,
  6: 438.33,
  7: 446.00,
  8: 453.67,
};
```

### 6.3 계산 (의사코드)

```dart
totalMeters = laneDistancesMeters[lane]! * laps;
paceSecPerKm = (seconds * 1000 / totalMeters).round();
```

### 6.4 Golden 테스트 케이스

| lane | laps | sec | paceSec/km | display |
|------|------|-----|------------|---------|
| 1 | 1 | 90 | 225 | 3:45/km |
| 2 | 1 | 90 | 221 | 3:41/km |
| 8 | 1 | 90 | 198 | 3:18/km |
| 1 | 2 | 180 | 225 | 3:45/km |
| 1 | 1 | 60 | 150 | 2:30/km |
| 8 | 20 | 3600 | 397 | 6:37/km |

검증식 예 (1레인 1바퀴 90초):  
`90 × 1000 / 400 = 225` → **3:45/km**

---

## 7. 입력 검증 (F8)

| 필드 | 차단 방식 |
|------|-----------|
| 레인 | 1~8 버튼만 — 0·9 입력 경로 없음 |
| 바퀴 | Stepper 상한 20, TextField 시 `FilteringTextInputFormatter` + clamp |
| 초 | Stepper 상한 3600, TextField clamp 1~3600 |
| 비현실적 값 (예: 1바퀴 10초) | **허용** — 계산만 수행 (육상 고수 시나리오). 별도 경고 없음 |
| 초 = 0 | 계산 스킵, placeholder |

---

## 8. 테마·디자인 토큰

트랙 경기장 컬러 기반 **라이트 테마 고정**.

| 토큰 | 값 (권장) | 용도 |
|------|-----------|------|
| `trackRed` | `#C41E3A` | 선택 레인, AppBar, 악센트 |
| `infieldGreen` | `#2D6A4F` | 히어로 카드, 프라이머리 |
| `laneLineWhite` | `#F8F9FA` | 카드·배경 |
| `textPrimary` | `#212529` | 본문 |
| `textSecondary` | `#6C757D` | 부제, 비선택 레인 |
| `highlightBg` | `#C41E3A` @ 12% opacity | 선택 레인 행 배경 |

| 타이포 | 용도 |
|--------|------|
| `displayLarge` | 히어로 페이스 (예: 48sp, bold) |
| `titleMedium` | 섹션 제목 |
| `bodyLarge` | 전 레인 목록 |

- Material 3 `ThemeData` + `ColorScheme.fromSeed(seedColor: trackRed)` 권장
- 다크 모드: **미구현** (`themeMode: ThemeMode.light`)

---

## 9. 문자열 리소스 (한국어)

| 키 | 문구 |
|----|------|
| `section_lane` | 레인 선택 |
| `section_laps` | 랩 카운트 |
| `section_time` | 목표 시간 |
| `section_all_lanes` | 전 레인 페이스 |
| `unit_seconds` | 초 |
| `unit_per_km` | /km |
| `hint_time` | 목표 시간을 입력하세요 |
| `privacy_policy` | 개인정보처리방침 |
| `subtitle_format` | `{lane}레인 · {laps}랩 · {seconds}초` |

앱 표시명: **추후 결정** (임시: `트랙 페이스 계산기`)

---

## 10. 스토어·설정 (최소)

| 항목 | MVP |
|------|-----|
| 개인정보처리방침 | AppBar 메뉴 또는 화면 하단 `TextButton` → 외부 브라우저 (네이버 블로그 URL, 출시 전 확정) |
| 권한 | 없음 |
| 오프라인 | `INTERNET` 권한 없이도 정상; 정책 URL만 브라우저 오픈 시 OS가 처리 |

---

## 11. 단위 테스트 범위

파일: `test/pace_calculator_test.dart`

| 테스트 | 내용 |
|--------|------|
| `formatPace` | 225 → `3:45/km`, 90 → `1:30/km`, 59 → `0:59/km` |
| `paceSecondsPerKm` | §6.4 golden 전 행 |
| `calculateAll` | 8개 결과, 길이 8, 레인 순 정렬 |
| monotonic | 동일 laps·seconds에서 lane 8 pace &lt; lane 1 pace |

위젯 테스트: **v1.0 제외**

---

## 12. 구현 체크리스트

- [ ] `lane_distances.dart` + `pace_calculator.dart`
- [ ] `pace_calculator_test.dart` green
- [ ] `home_screen.dart` 단일 화면
- [ ] `input_storage.dart` + 앱 시작 복원
- [ ] `presets.dart` + PresetChips
- [ ] 테마 토큰 적용
- [ ] 개인정보 링크 placeholder URL → 출시 전 교체
- [ ] Android / iOS 릴리즈 빌드·스토어 메타

---

## 변경 이력

| 버전 | 날짜 | 내용 |
|------|------|------|
| 1.0 | 2026-05-18 | requirements v1.0 기반 최초 명세 |
