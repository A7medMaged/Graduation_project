class ModeState {
  final bool? automaticR;
  final bool isLoading;

  const ModeState({this.automaticR, this.isLoading = true});

  ModeState copyWith({bool? automaticR1, bool? automaticR2, bool? isLoading}) {
    return ModeState(
      automaticR: automaticR1 ?? automaticR,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
