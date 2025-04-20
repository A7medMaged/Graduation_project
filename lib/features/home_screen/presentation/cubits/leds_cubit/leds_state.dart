class LedsState {
  final bool room1Led;
  final bool room2Led;

  LedsState({required this.room1Led, required this.room2Led});

  factory LedsState.initial() => LedsState(room1Led: false, room2Led: false);

  LedsState copyWith({bool? room1Led, bool? room2Led}) {
    return LedsState(
      room1Led: room1Led ?? this.room1Led,
      room2Led: room2Led ?? this.room2Led,
    );
  }
}
