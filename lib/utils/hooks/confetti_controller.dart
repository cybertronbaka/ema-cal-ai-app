import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ConfettiController useConfettiController({
  Duration duration = const Duration(seconds: 10),
  void Function(ParticleStats)? particleStatsCallback,
  String debugLabel = 'useConfettiController',
  bool debug = false,
}) {
  final controller = useMemoized(() {
    if (debug) debugPrint('$debugLabel: Memoizing');
    return ConfettiController(
      duration: duration,
      particleStatsCallback: particleStatsCallback,
    );
  }, []);

  useEffect(() => controller.dispose, []);

  return controller;
}
