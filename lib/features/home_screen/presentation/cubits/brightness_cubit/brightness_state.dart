class BrightnessState {
  final double brightness;
  final bool isLoading;
  final String? error;

  BrightnessState({
    required this.brightness,
    required this.isLoading,
    this.error,
  });

  factory BrightnessState.initial() {
    return BrightnessState(
      brightness: 0.0,
      isLoading: true,
      error: null,
    );
  }

  BrightnessState copyWith({
    double? brightness,
    bool? isLoading,
    String? error,
  }) {
    return BrightnessState(
      brightness: brightness ?? this.brightness,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}