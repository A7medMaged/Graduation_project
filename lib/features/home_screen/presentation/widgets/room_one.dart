import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_state.dart';
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
      appBar: AppBar(
        title: Text('Room 1'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<LedsCubit, LedsState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DeviceControl(
                isOn: state.room1Led,
                iconOn: Icons.lightbulb,
                iconOff: Icons.lightbulb_outline,
                deviceName: 'Led',
                onPressed: () {
                  context.read<LedsCubit>().toggleRoom1Led();
                },
              ),
              const SizedBox(height: 16),
              Text('Temperature: ${state.tempSensor}°C'),
              Text('Humidity: ${state.humidity}%'),
            ],
          );
        },
      ),
    );
  }
}
