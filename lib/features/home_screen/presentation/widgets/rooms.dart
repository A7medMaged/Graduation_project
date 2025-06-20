import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/home_control.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            HomeControl(
              roomName: 'Room Modes',
              onTap: () => GoRouter.of(context).push(AppRoutes.mode),
              svgName: 'room',
            ),
            const SizedBox(height: 16),
            HomeControl(
              roomName: 'Room 1',
              onTap: () => GoRouter.of(context).push(AppRoutes.roomOne),
              svgName: 'room',
            ),
            const SizedBox(height: 16),
            HomeControl(
              roomName: 'Room 2',
              onTap: () => GoRouter.of(context).push(AppRoutes.roomTwo),
              svgName: 'room',
            ),
          ],
        ),
      ),
    );
  }
}
