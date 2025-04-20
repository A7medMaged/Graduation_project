import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_state.dart';
import 'package:toastification/toastification.dart';

class Kitchen extends StatelessWidget {
  const Kitchen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Sensors'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<SensorsCubit, SensorsState>(
        listener: (context, state) {
          if (state.gasDetected) {
            toastification.show(
              // ignore: use_build_context_synchronously
              context: context,
              title: const Text('Warning!'),
              description: const Text(
                'Gas Leak Detected! Please take action immediately.',
              ),
              type: ToastificationType.warning,
              style: ToastificationStyle.minimal,
              autoCloseDuration: const Duration(seconds: 5),
            );
          } else if (state.flameDetected) {
            toastification.show(
              // ignore: use_build_context_synchronously
              context: context,
              title: const Text('Warning!'),
              description: const Text(
                'Flame Detected! Please take action immediately.',
              ),
              type: ToastificationType.warning,
              style: ToastificationStyle.minimal,
              autoCloseDuration: const Duration(seconds: 5),
            );
          } else {
            toastification.show(
              // ignore: use_build_context_synchronously
              context: context,
              title: const Text('All Clear!'),
              description: const Text('No gas or flame detected.'),
              type: ToastificationType.success,
              style: ToastificationStyle.minimal,
              autoCloseDuration: const Duration(seconds: 5),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 25,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/smoke.svg',
                          height: 62,
                          width: 62,
                          colorFilter: ColorFilter.mode(
                            state.gasDetected ? Colors.red : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.gasDetected ? 'Gas Detected' : 'No Gas',
                          style: TextStyle(
                            fontSize: 32,
                            color: state.gasDetected ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/flame.svg',
                          height: 62,
                          width: 62,
                          colorFilter: ColorFilter.mode(
                            state.flameDetected ? Colors.red : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.flameDetected ? 'Flame Detected' : 'No Flame',
                          style: TextStyle(
                            fontSize: 32,
                            color:
                                state.flameDetected ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
