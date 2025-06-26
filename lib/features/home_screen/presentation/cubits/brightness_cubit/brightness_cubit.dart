import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/repos/brightness_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/brightness_cubit/brightness_state.dart';

class BrightnessCubit extends Cubit<BrightnessState> {
  final BrightnessRepo _repository;
  StreamSubscription? _brightnessSubscription;

  BrightnessCubit(this._repository) : super(BrightnessState.initial()) {
    _startListening();
  }

  void _startListening() {
    _brightnessSubscription?.cancel();
    
    _brightnessSubscription = _repository.getBrightnessStream().listen((brightness) {
      // Check if cubit is closed before emitting
      if (!isClosed) {
        emit(state.copyWith(brightness: brightness, isLoading: false, error: ''));
      }
    }, onError: (error) {
      if (!isClosed) {
        emit(state.copyWith(error: error.toString(), isLoading: false));
      }
    });
  }

  void updateBrightness(double value) async {
    try {
      emit(state.copyWith(isLoading: true, error: ''));
      await _repository.setBrightness(value);
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    }
  }

  @override
  Future<void> close() {
    _brightnessSubscription?.cancel();
    _brightnessSubscription = null;
    return super.close();
  }
}