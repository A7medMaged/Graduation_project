import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_state.dart';
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
      appBar: AppBar(title: const Text('Room 2'), centerTitle: true),
      body: BlocBuilder<LedsCubit, LedsState>(
        builder: (context, state) {
          return DeviceControl(
            isOn: state.room2Led,
            iconOn: Icons.lightbulb,
            iconOff: Icons.lightbulb_outline,
            deviceName: 'Led',
            onPressed: () {
              context.read<LedsCubit>().toggleRoom2Led();
            },
          );
        },
      ),
    );
  }
}
