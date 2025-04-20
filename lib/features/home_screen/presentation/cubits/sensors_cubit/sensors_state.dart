class SensorsState {
  final bool flameDetected;
  final bool gasDetected;

  SensorsState({required this.flameDetected, required this.gasDetected});

  factory SensorsState.initial() =>
      SensorsState(flameDetected: false, gasDetected: false);

  SensorsState copyWith({bool? flameDetected, bool? gasDetected}) {
    return SensorsState(
      flameDetected: flameDetected ?? this.flameDetected,
      gasDetected: gasDetected ?? this.gasDetected,
    );
  }
}
