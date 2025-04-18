import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/register/data/register_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo = RegisterRepo();
  RegisterCubit(RegisterRepo registerRepo) : super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    emit(RegisterLoading());
    try {
      await _registerRepo.register(email, password, name, phone, role);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
