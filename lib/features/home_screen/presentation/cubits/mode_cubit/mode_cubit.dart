import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/repos/mode_repo.dart';
import 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  final ModeRepository repo;
  StreamSubscription<bool?>? _r1Sub;
  StreamSubscription<bool?>? _r2Sub;

  ModeCubit(this.repo) : super(const ModeState()) {
    _r1Sub = repo.streamR1().listen((value) {
      emit(
        state.copyWith(
          automaticR1: value,
          isLoading: false, 
        ),
      );
    });

    _r2Sub = repo.streamR2().listen((value) {
      emit(state.copyWith(automaticR2: value));
    });
  }

  void toggleR1() {
    final current = state.automaticR1 ?? false;
    repo.setR1(!current);
  }

  void toggleR2() {
    final current = state.automaticR2 ?? false;
    repo.setR2(!current);
  }

  @override
  Future<void> close() {
    _r1Sub?.cancel();
    _r2Sub?.cancel();
    return super.close();
  }
}
