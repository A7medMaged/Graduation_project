import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/repos/sensors_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final SensorsRepo _repository;
  StreamSubscription? _kitchenSubscription;

  SensorsCubit(this._repository) : super(SensorsState.initial()) {
    _initStreams();
  }

  void _initStreams() {
    _kitchenSubscription?.cancel();

    _kitchenSubscription = _repository.getKitchenSensors().listen((sensors) {
      if (!isClosed) {
        emit(
          state.copyWith(
            flameDetected: sensors['flame_sensor'] == 1,
            gasDetected: sensors['gas_sensor'] == 1,
          ),
        );
      }
    });
  }

  void startMointring() {
    if (_kitchenSubscription == null) {
      _initStreams();
    }
  }

  @override
  Future<void> close() {
    _kitchenSubscription?.cancel();
    return super.close();
  }
}
