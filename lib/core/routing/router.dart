import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/features/home_screen/presentation/home_screen.dart';
import 'package:smart_home/features/login_screen/presentation/login_screen.dart';
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
        builder: (context, state) => const LoginScreen(),
      ),
       GoRoute(
        path: AppRoutes.registerScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
