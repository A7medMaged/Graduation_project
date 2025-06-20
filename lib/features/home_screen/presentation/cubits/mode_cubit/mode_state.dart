class ModeState {
  final bool? automaticR1;
  final bool? automaticR2;
  final bool isLoading;

  const ModeState({
    this.automaticR1,
    this.automaticR2,
    this.isLoading = true,
  });

  ModeState copyWith({
    bool? automaticR1,
    bool? automaticR2,
    bool? isLoading,
  }) {
    return ModeState(
      automaticR1: automaticR1 ?? this.automaticR1,
      automaticR2: automaticR2 ?? this.automaticR2,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
