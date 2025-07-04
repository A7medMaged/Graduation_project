import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/helper/face_cam.dart';
import 'package:smart_home/core/helper/fire_cam.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/features/home_screen/data/repos/leds_repo.dart';
import 'package:smart_home/features/home_screen/data/repos/sensors_repo.dart';
import 'package:smart_home/features/home_screen/presentation/child_home_screen.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/father_home_screen.dart';
import 'package:smart_home/features/home_screen/presentation/mother_home_screen.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/kitchen.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/mode_screen.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_one.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_two.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/rooms.dart';
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
        builder: (context, state) => const FatherHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(LoginRepo()),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.registerScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(RegisterRepo()),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.userScreen,
        builder: (context, state) => const UserProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.rooms,
        builder: (context, state) => BlocProvider(
          create: (context) => LedsCubit(LedsRepo()),
          child: const Rooms(),
        ),
      ),
      GoRoute(
        path: AppRoutes.roomOne,
        builder: (context, state) => BlocProvider(
          create: (context) => LedsCubit(LedsRepo()),
          child: const RoomOne(),
        ),
      ),
      GoRoute(
        path: AppRoutes.roomTwo,
        builder: (context, state) => BlocProvider(
          create: (context) => LedsCubit(LedsRepo()),
          child: const RoomTwo(),
        ),
      ),
      GoRoute(
        path: AppRoutes.kitchen,
        builder: (context, state) => BlocProvider(
          create: (context) => SensorsCubit(SensorsRepo()),
          child: const Kitchen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.fatherScreen,
        builder: (context, state) => const FatherHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.motherScreen,
        builder: (context, state) => const MotherHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.childScreen,
        builder: (context, state) => const ChildHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.mode,
        builder: (context, state) => const ToggleScreen(),
      ),
      GoRoute(
        path: AppRoutes.fireCam,
        builder: (context, state) => const FireCam(),
      ),
      GoRoute(
        path: AppRoutes.faceCam,
        builder: (context, state) =>
            const FaceCam(), // Placeholder for face camera
      ),
    ],
  );
}
