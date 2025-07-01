import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
    return BlocBuilder<LedsCubit, LedsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return  Center(
            child: Skeletonizer(
              child: DeviceControl(
                textOn: 'On',
                textOff: 'Off',
                isOn: false,
                iconOn: Icons.lightbulb,
                iconOff: Icons.lightbulb_outline,
                deviceName: 'Room 2',
                onPressed: () {},
              ),
            ),
          );
        }
        return DeviceControl(
          textOn: 'On',
          textOff: 'Off',
          isOn: state.room2Led,
          iconOn: Icons.lightbulb,
          iconOff: Icons.lightbulb_outline,
          deviceName: 'Room 2',
          onPressed: () {
            context.read<LedsCubit>().toggleRoom2Led();
          },
        );
      },
    );
  }
}
