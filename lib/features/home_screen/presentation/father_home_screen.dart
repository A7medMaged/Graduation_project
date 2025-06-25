import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/helper/fire_cam.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/home_control.dart';

class FatherHomeScreen extends StatelessWidget {
  const FatherHomeScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            HomeControl(
              roomName: 'Kitchen',
              onTap: () {
                GoRouter.of(context).push(AppRoutes.kitchen);
              },
              svgName: 'kitchen',
            ),
            HomeControl(
              roomName: 'Rooms',
              onTap: () {
                GoRouter.of(context).push(AppRoutes.rooms);
              },
              svgName: 'room',
            ),
            HomeControl(
              roomName: 'Fire Camera',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FireCam()),
                );
              },
              svgName: 'flame',
            ),
            HomeControl(
              roomName: 'Face Recognition',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FireCam()),
                );
              },
              svgName: 'face',
            ),
          ],
        ),
      ),
    );
  }
}
