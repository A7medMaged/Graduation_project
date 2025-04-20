import 'package:flutter/material.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/device_control.dart';

class RoomOne extends StatefulWidget {
  const RoomOne({super.key});

  @override
  State<RoomOne> createState() => _RoomOneState();
}

class _RoomOneState extends State<RoomOne> {
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
