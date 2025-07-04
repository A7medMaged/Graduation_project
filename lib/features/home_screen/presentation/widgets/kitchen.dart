import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/core/helper/notification_service.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_state.dart';
import 'package:toastification/toastification.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({super.key});

  @override
  State<Kitchen> createState() => _KitchenState();
}

final NotificationService notificationService = NotificationService();

class _KitchenState extends State<Kitchen> {
  @override
  void initState() {
    super.initState();
    notificationService.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: secondary.withOpacity(0.85),
      appBar: AppBar(
        title: const Text('Kitchen Sensors'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/kitchen.jpg', fit: BoxFit.cover),
          // ignore: deprecated_member_use
          Container(color: Colors.black.withOpacity(0.4)),
          BlocConsumer<SensorsCubit, SensorsState>(
            listener: (context, state) {
              if (!state.gasDetected && !state.flameDetected) {
                toastification.show(
                  context: context,
                  title: const Text('All Clear!'),
                  description: const Text('No gas or fire detected.'),
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
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2.2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _statusCard(
                            svgPath: 'assets/svgs/smoke.svg',
                            detected: state.gasDetected,
                            labelOn: 'Gas Detected',
                            labelOff: 'No Gas Detected',
                          ),
                          _statusCard(
                            svgPath: 'assets/svgs/flame.svg',
                            detected: state.flameDetected,
                            labelOn: 'Fire Detected',
                            labelOff: 'No Fire Detected',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required String svgPath,
    required bool detected,
    required String labelOn,
    required String labelOff,
  }) {
    return Card(
      // ignore: deprecated_member_use
      color: secondary.withOpacity(0.85),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 62,
            width: 62,
            colorFilter: ColorFilter.mode(
              detected ? Colors.red : white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            detected ? labelOn : labelOff,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: detected ? Colors.red : white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
