import 'package:firebase_auth/firebase_auth.dart';
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
    required int buildingNo,
    required int apartmentNo,
  }) async {
    emit(RegisterLoading());
    try {
      await _registerRepo.register(
        email,
        password,
        name,
        phone,
        role,
        buildingNo,
        apartmentNo,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'Registration failed: ${e.message}';
      }
      emit(RegisterFailure(errorMessage));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
