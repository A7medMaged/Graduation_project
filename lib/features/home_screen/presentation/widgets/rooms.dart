import 'package:flutter/material.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_one.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/room_two.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms'), backgroundColor: Colors.transparent),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [RoomOne(), RoomTwo()],
      ),
    );
  }
}
