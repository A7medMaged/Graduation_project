import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/features/home_screen/presentation/home_screen.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/user_profile.dart';
import 'package:smart_home/features/login/data/cubit/login_cubit.dart';
import 'package:smart_home/features/login/data/login_repo.dart';
import 'package:smart_home/features/login/presentation/login_screen.dart';
import 'package:smart_home/features/register/data/cubit/register_cubit.dart';
import 'package:smart_home/features/register/data/register_repo.dart';
import 'package:smart_home/features/register/presentation/register_screen.dart';
import 'package:smart_home/features/splash_screen/presentation/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => LoginCubit(LoginRepo()),
              child: const LoginScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.registerScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => RegisterCubit(RegisterRepo()),
              child: const RegisterScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.userScreen,
        builder: (context, state) => const UserProfileScreen(),
      ),
    ],
  );
}
