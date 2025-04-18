import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/core/theming/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/svgs/user-round.svg",
              colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
              width: 24,
            ),
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.userScreen);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyles.font24BlueBold,
        ),
      ),
    );
  }
}
