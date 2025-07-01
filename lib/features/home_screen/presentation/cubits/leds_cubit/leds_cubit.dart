import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/repos/leds_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_state.dart';

class LedsCubit extends Cubit<LedsState> {
  final LedsRepo _repository;
  StreamSubscription? _roomsSubscription;

  LedsCubit(this._repository) : super(LedsState.initial()) {
    _initStreams();
  }

  void _initStreams() {
    _roomsSubscription?.cancel();

    _roomsSubscription = _repository.getRooms().listen((rooms) {
      if (!isClosed) {
        emit(
          state.copyWith(
            room1Led: rooms['room_one'] == 1,
            room2Led: rooms['room_two'] == 1,
            tempSensor: int.tryParse(rooms['temp_sensor'].toString()) ?? 0,
            humidity: int.tryParse(rooms['humidity'].toString()) ?? 0,
            isLoading: false,
          ),
        );
      }
    });
  }

  Future<void> toggleRoom1Led() async {
    await _repository.toggleLed('room_one', state.room1Led ? 1 : 0);
  }

  Future<void> toggleRoom2Led() async {
    await _repository.toggleLed('room_two', state.room2Led ? 1 : 0);
  }

  @override
  Future<void> close() {
    _roomsSubscription?.cancel();
    return super.close();
  }
}
