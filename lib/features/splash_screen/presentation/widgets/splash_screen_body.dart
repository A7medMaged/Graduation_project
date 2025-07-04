import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/enum/user_role.dart';
import 'package:smart_home/core/helper/assets.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/data/repos/user_repo.dart';
import 'package:smart_home/features/home_screen/data/user_model.dart';
import 'package:smart_home/features/splash_screen/presentation/widgets/sliding_text.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        final userRepo = UserRepo();
        final userData = await userRepo.getUserDetails(user.uid);
        final userModel = UserModel.fromMap(userData);
        switch (userModel.role) {
          case UserRole.father:
            if (mounted) GoRouter.of(context).go(AppRoutes.fatherScreen);
            break;
          case UserRole.mother:
            if (mounted) GoRouter.of(context).go(AppRoutes.motherScreen);
            break;
          case UserRole.child:
            if (mounted) GoRouter.of(context).go(AppRoutes.childScreen);
            break;
        }
      } else {
        if (mounted) GoRouter.of(context).go(AppRoutes.loginScreen);
      }
    });
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetsData.logo, color: mainColor, height: 200, width: 200),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }
}
