import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/user_cubit/user_state.dart';
import 'package:smart_home/features/home_screen/data/repos/user_repo.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/shimmer_loading.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/signout_section.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/user_avatar.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/user_details.dart';
import 'package:smart_home/features/login/data/cubit/login_cubit.dart';
import 'package:smart_home/features/login/data/login_repo.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginCubit(LoginRepo())),
            BlocProvider(
              create: (context) => UserCubit(UserRepo())..fetchCurrentUser(),
            ),
          ],
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserInitial || state is UserLoading) {
                return const Center(child: Loading());
              } else if (state is UserError) {
                return Center(child: Text(state.message));
              } else if (state is UserLoaded) {
                final user = state.user;
                final formattedDate = DateFormat(
                  'MMMM dd, yyyy - hh:mm a',
                ).format(user.registerTime);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Avatar(),
                      SizedBox(height: 20.h),
                      Details(
                        title: "Name",
                        subtitle: user.name,
                        icon: Icons.person,
                      ),
                      Details(
                        title: "E-mail",
                        subtitle: user.email,
                        icon: Icons.email,
                      ),
                      Details(
                        title: "Phone",
                        subtitle: user.phone,
                        icon: Icons.phone,
                      ),
                      Details(
                        title: "Role",
                        subtitle: state.user.role.name,
                        icon: Icons.verified_user,
                      ),
                      Details(
                        title: "Register Time",
                        subtitle: formattedDate,
                        icon: Icons.access_time,
                      ),
                      SignoutSection(),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Unknown state'));
            },
          ),
        ),
      ),
    );
  }
}
