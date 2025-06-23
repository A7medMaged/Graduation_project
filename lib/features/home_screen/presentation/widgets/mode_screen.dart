import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/data/repos/brightness_repo.dart';
import 'package:smart_home/features/home_screen/data/repos/mode_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/brightness_cubit/brightness_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/brightness_cubit/brightness_state.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/mode_cubit/mode_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/mode_cubit/mode_state.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/device_control.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ModeCubit(ModeRepository())),
        BlocProvider(create: (context) => BrightnessCubit(BrightnessRepo())),
      ],
      child: const _ToggleScreenContent(),
    );
  }
}

class _ToggleScreenContent extends StatelessWidget {
  const _ToggleScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Modes')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            BlocBuilder<ModeCubit, ModeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
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
                );
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<BrightnessCubit, BrightnessState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFFBF0),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.light_mode_outlined,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Brightness',
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              state.brightness.toInt().toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        activeColor: black,
                        value: state.brightness,
                        min: 0,
                        max: 255,
                        onChanged: (value) {
                          context.read<BrightnessCubit>().updateBrightness(
                            value,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
