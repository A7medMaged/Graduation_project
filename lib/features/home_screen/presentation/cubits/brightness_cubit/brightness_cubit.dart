import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/repos/brightness_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/brightness_cubit/brightness_state.dart';

class BrightnessCubit extends Cubit<BrightnessState> {
  final BrightnessRepo repo;

  BrightnessCubit(this.repo) : super(const BrightnessState(brightness: 0)) {
    _startListening();
  }

  void _startListening() {
    repo.getBrightnessStream().listen((value) {
      emit(state.copyWith(brightness: value));
    });
  }

  Future<void> updateBrightness(double value) async {
    await repo.setBrightness(value);
    emit(state.copyWith(brightness: value));
  }
}
