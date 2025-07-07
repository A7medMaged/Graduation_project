import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';

import 'package:smart_home/core/enum/user_role.dart';
import 'package:smart_home/core/helper/assets.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/data/repos/user_repo.dart';
import 'package:smart_home/features/home_screen/data/user_model.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/offline_screen.dart';
import 'package:smart_home/features/splash_screen/presentation/widgets/sliding_text.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _slidingAnim;
  StreamSubscription? _connectionSub;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _connectionSub = InternetConnection().onStatusChange.listen((_) {});
  }

  void _initAnimation() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _slidingAnim = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(_animController);
    _animController.forward();
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startNavigation();
      }
    });
  }

  void _startNavigation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        tryNavigate();
      }
    });
  }

  Future<void> tryNavigate() async {
    final hasNet = await InternetConnection().hasInternetAccess;
    if (!hasNet) {
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          barrierDismissible: false,
          builder: (_) => OfflineScreen(
            onRetry: () async {
              const GFLoader(type: GFLoaderType.ios);
              await tryNavigate();
            },
          ),
        ),
      );
      return;
    }

    await _navigateByUserRole();
  }

  Future<void> _navigateByUserRole() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      try {
        final userRepo = UserRepo();
        final userData = await userRepo.getUserDetails(user.uid);
        final userModel = UserModel.fromMap(userData);

        if (kDebugMode) {
          Logger().i('User role: ${userModel.role}');
        }

        switch (userModel.role) {
          case UserRole.father:
            if (mounted) context.go(AppRoutes.fatherScreen);
            break;
          case UserRole.mother:
            if (mounted) context.go(AppRoutes.motherScreen);
            break;
          case UserRole.child:
            if (mounted) context.go(AppRoutes.childScreen);
            break;
        }
      } catch (e) {
        if (kDebugMode) {
          Logger().e('Error getting user data: $e');
        }
        if (mounted) context.go(AppRoutes.loginScreen);
      }
    } else {
      if (mounted) context.go(AppRoutes.loginScreen);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _connectionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetsData.logo, height: 200, width: 200, color: mainColor),
        const SizedBox(height: 20),
        SlidingText(slidingAnimation: _slidingAnim),
      ],
    );
  }
}
