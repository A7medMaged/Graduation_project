class BrightnessState {
  final double brightness;
  final bool isLoading;

  const BrightnessState({required this.brightness, this.isLoading = false});

  BrightnessState copyWith({double? brightness, bool? isLoading}) {
    return BrightnessState(
      brightness: brightness ?? this.brightness,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BrightnessState &&
            other.brightness == brightness &&
            other.isLoading == isLoading);
  }

  @override
  int get hashCode => brightness.hashCode ^ isLoading.hashCode;
}
