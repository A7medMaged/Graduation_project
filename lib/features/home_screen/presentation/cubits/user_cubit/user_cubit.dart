import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/data/user_model.dart';
import 'package:smart_home/features/home_screen/data/repos/user_repo.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;

  UserCubit(this.userRepo) : super(UserInitial());

  Future<void> fetchCurrentUser() async {
    emit(UserLoading());
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userData = await userRepo.getUserDetails(currentUser.uid);
        final user = UserModel.fromMap(userData);
        emit(UserLoaded(user));
      } else {
        emit(const UserError('No user logged in'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
