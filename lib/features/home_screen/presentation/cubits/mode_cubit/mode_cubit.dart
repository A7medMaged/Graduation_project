import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/repos/mode_repo.dart';
import 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  final ModeRepo repo;
  StreamSubscription<bool?>? _rSub;

  ModeCubit(this.repo) : super(const ModeState()) {
    _rSub = repo.streamR().listen((value) {
      emit(state.copyWith(automaticR1: value, isLoading: false));
    });
  }

  void toggleR1() {
    final current = state.automaticR ?? false;
    repo.setR(!current);
  }

  @override
  Future<void> close() {
    _rSub?.cancel();
    return super.close();
  }
}
