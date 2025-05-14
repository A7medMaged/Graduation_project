class LedsState {
  final bool room1Led;
  final bool room2Led;
  final String tempSensor;
  final int humidity;
  final bool isLoading;

  LedsState({
    required this.room1Led,
    required this.room2Led,
    required this.tempSensor,
    required this.humidity,
    required this.isLoading,
  });

  factory LedsState.initial() => LedsState(
    room1Led: false,
    room2Led: false,
    tempSensor: '0',
    humidity: 0,
    isLoading: true,
  );

  LedsState copyWith({
    bool? room1Led,
    bool? room2Led,
    String? tempSensor,
    int? humidity,
    bool? isLoading,
  }) {
    return LedsState(
      room1Led: room1Led ?? this.room1Led,
      room2Led: room2Led ?? this.room2Led,
      tempSensor: tempSensor ?? this.tempSensor,
      humidity: humidity ?? this.humidity,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
