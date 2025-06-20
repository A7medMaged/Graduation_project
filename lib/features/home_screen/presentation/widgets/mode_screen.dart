import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home/features/home_screen/data/repos/mode_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/mode_cubit/mode_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/mode_cubit/mode_state.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/device_control.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModeCubit(ModeRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Room Modes')),
        body: BlocBuilder<ModeCubit, ModeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DeviceControl(
                    textOn: 'True',
                    textOff: 'False',
                    isOn: state.automaticR1 ?? false,
                    iconOn: FontAwesomeIcons.toggleOn,
                    iconOff: FontAwesomeIcons.toggleOff,
                    deviceName: 'Room 1 Mode',
                    onPressed: () {
                      context.read<ModeCubit>().toggleR1();
                    },
                  ),
                  const SizedBox(height: 16),
                  DeviceControl(
                    textOn: 'True',
                    textOff: 'False',
                    isOn: state.automaticR2 ?? false,
                    iconOn: FontAwesomeIcons.toggleOn,
                    iconOff: FontAwesomeIcons.toggleOff,
                    deviceName: 'Room 2 Mode',
                    onPressed: () {
                      context.read<ModeCubit>().toggleR2();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
