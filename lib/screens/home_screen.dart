import 'dart:async';

import 'package:flutter/material.dart';
import 'package:track/l10n/app_localizations.dart';

import '../data/lane_distances.dart';
import '../models/calculation_output.dart';
import '../models/training_input.dart';
import '../services/input_storage.dart';
import '../services/pace_calculator.dart';
import '../theme/app_colors.dart';
import '../utils/time_format.dart';
import '../widgets/all_lanes_list.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/app_branding.dart';
import '../widgets/lane_selector.dart';
import '../widgets/pace_guide_banner.dart';
import '../widgets/pace_hero_card.dart';
import '../widgets/value_input_row.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _lane = 1;
  int _laps = 1;
  int _seconds = 90;

  CalculationOutput? _output;
  bool _isRestoring = true;
  Timer? _saveDebounce;

  TrainingInput get _input =>
      TrainingInput(lane: _lane, laps: _laps, seconds: _seconds);

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    final saved = await InputStorage.load();
    if (saved != null && mounted) {
      setState(() {
        _lane = saved.lane;
        _laps = saved.laps;
        _seconds = saved.seconds;
      });
    }
    _recalculate();
    if (mounted) {
      setState(() => _isRestoring = false);
    }
  }

  void _recalculate() {
    if (!_input.isValid) {
      return;
    }
    setState(() => _output = PaceCalculator.calculateAll(_input));
  }

  void _scheduleSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 300), () {
      InputStorage.save(_input);
    });
  }

  void _updateInput({
    int? lane,
    int? laps,
    int? seconds,
    bool showSecondsClampedNotice = false,
  }) {
    setState(() {
      if (lane != null) _lane = lane;
      if (laps != null) _laps = laps;
      if (seconds != null) _seconds = seconds;
    });
    _recalculate();
    _scheduleSave();

    if (showSecondsClampedNotice && mounted) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.maxSecondsNotice),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _onLaneSelected(int lane) {
    _updateInput(lane: lane);
  }

  void _onLapsChanged(int newLaps) {
    final rawScaled = (_seconds * newLaps / _laps).round();
    final scaledSeconds = scaleSecondsForLaps(
      currentSeconds: _seconds,
      oldLaps: _laps,
      newLaps: newLaps,
      minSeconds: minSeconds,
      maxSeconds: maxSeconds,
    );
    _updateInput(
      laps: newLaps,
      seconds: scaledSeconds,
      showSecondsClampedNotice: rawScaled > maxSeconds,
    );
  }

  void _onSecondsChanged(int value) {
    _updateInput(seconds: value);
  }

  Future<void> _openSettings() async {
    final didReset = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => const SettingsScreen()),
    );

    if (didReset == true && mounted) {
      _applyReset();
    }
  }

  void _applyReset() {
    _saveDebounce?.cancel();
    const defaults = TrainingInput.initial;
    setState(() {
      _lane = defaults.lane;
      _laps = defaults.laps;
      _seconds = defaults.seconds;
    });
    _recalculate();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.resetSuccess),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_isRestoring || _output == null) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: AppBar(title: AppBarTitle(l10n.appTitle)),
        body: Center(child: AppBrandingLoader()),
      );
    }

    final output = _output!;
    final subtitle = l10n.resultSubtitle(_lane, _laps, _seconds);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: AppBarTitle(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.settingsTooltip,
            onPressed: _openSettings,
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _HeaderFieldLabel(l10n.selectLane),
                      const SizedBox(height: 10),
                      LaneSelector(
                        selectedLane: _lane,
                        onLaneSelected: _onLaneSelected,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ValueInputRow(
                      label: l10n.lapCount,
                      value: _laps,
                      unit: l10n.lapUnit,
                      min: minLaps,
                      max: maxLaps,
                      step: 1,
                      onChanged: _onLapsChanged,
                    ),
                    const SizedBox(height: 10),
                    ValueInputRow(
                      label: l10n.goalTime,
                      value: _seconds,
                      unit: l10n.secondsUnit,
                      subtitle: formatMinutesSeconds(context, _seconds),
                      min: minSeconds,
                      max: maxSeconds,
                      step: 1,
                      onChanged: _onSecondsChanged,
                    ),
                    const SizedBox(height: 12),
                    PaceHeroCard(
                      paceText: heroPaceFromDisplay(output.selected.displayPace),
                      subtitle: subtitle,
                    ),
                    const SizedBox(height: 10),
                    PaceGuideBanner(
                      lane: _lane,
                      laps: _laps,
                      seconds: _seconds,
                    ),
                    const SizedBox(height: 10),
                    AllLanesList(
                      results: output.allLanes,
                      selectedLane: _lane,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderFieldLabel extends StatelessWidget {
  const _HeaderFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnPrimary,
      ),
    );
  }
}
