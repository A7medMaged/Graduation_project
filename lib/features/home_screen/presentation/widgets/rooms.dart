import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/home_control.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_one.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_two.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            HomeControl(
              roomName: 'Room Modes',
              onTap: () => GoRouter.of(context).push(AppRoutes.mode),
              svgName: 'room',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.1,
                children: [RoomOne(), RoomTwo()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
