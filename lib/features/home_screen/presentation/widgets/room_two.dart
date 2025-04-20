import 'package:flutter/material.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/device_control.dart';

class RoomTwo extends StatefulWidget {
  const RoomTwo({super.key});

  @override
  State<RoomTwo> createState() => _RoomTwoState();
}

class _RoomTwoState extends State<RoomTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Sensors'), centerTitle: true),
      body: DeviceControl(
        isOn: false,
        iconOn: Icons.lightbulb,
        iconOff: Icons.lightbulb_outline,
        deviceName: 'Led',
        onPressed: () {},
      ),
    );
  }
}
