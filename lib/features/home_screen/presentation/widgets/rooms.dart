import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/home_control.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_one.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_two.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        // ignore: deprecated_member_use
        backgroundColor: secondary.withOpacity(0.85),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/room.jpg', fit: BoxFit.cover),
          // ignore: deprecated_member_use
          Container(color: secondary.withOpacity(0.4)),

          Padding(
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
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: const [RoomOne(), RoomTwo()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
