import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
        BlocProvider(create: (context) => ModeCubit(ModeRepo())),
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
      appBar: AppBar(
        title: const Text('Room Modes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            BlocBuilder<ModeCubit, ModeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Skeletonizer(
                    child: Column(
                      children: [
                        DeviceControl(
                          textOn: 'True',
                          textOff: 'False',
                          isOn: false,
                          iconOn: FontAwesomeIcons.toggleOn,
                          iconOff: FontAwesomeIcons.toggleOff,
                          deviceName: 'Automatic',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    DeviceControl(
                      textOn: 'True',
                      textOff: 'False',
                      isOn: state.automaticR ?? false,
                      iconOn: FontAwesomeIcons.toggleOn,
                      iconOff: FontAwesomeIcons.toggleOff,
                      deviceName: 'Automatic',
                      onPressed: () {
                        context.read<ModeCubit>().toggleR1();
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
                  return Skeletonizer(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: scaffoldColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: mainColor,
                            blurRadius: 8,
                            offset: Offset(0, 4),
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
                                color: mainColor,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Brightness',
                                style: TextStyle(
                                  color: mainColor,
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
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  '125',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Slider(
                            activeColor: mainColor,
                            value: 125,
                            min: 0,
                            max: 255,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: mainColor.withOpacity(0.5),
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
                            color: mainColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Brightness',
                            style: TextStyle(
                              color: mainColor,
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
                              color: mainColor,
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
                        activeColor: mainColor,
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
