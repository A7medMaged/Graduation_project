import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/helper/face_cam.dart';
import 'package:smart_home/core/helper/fire_cam.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_state.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/home_control.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/humidity_progress.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/temp_bar.dart';

class FatherHomeScreen extends StatefulWidget {
  const FatherHomeScreen({super.key});

  @override
  State<FatherHomeScreen> createState() => _FatherHomeScreenState();
}

class _FatherHomeScreenState extends State<FatherHomeScreen> {
  Color _getTempColor(int temp) {
    if (temp < 25) return Colors.blue;
    if (temp < 30) return Colors.orange;
    return Colors.red;
  }

  Color _getHumidityColor(int humidity) {
    if (humidity < 30) return Colors.blue;
    if (humidity < 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/svgs/user-round.svg",
              colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
              width: 24,
            ),
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.userScreen);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            BlocBuilder<LedsCubit, LedsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TemperatureBar(
                        temperature: state.tempSensor,
                        color: _getTempColor(state.tempSensor),
                      ),
                      Container(
                        height: 70,
                        width: 1.2,
                        color: Colors.grey[300],
                      ),
                      HumidityProgress(
                        humidity: state.humidity,
                        color: _getHumidityColor(state.humidity),
                      ),
                    ],
                  ),
                );
              },
            ),
            HomeControl(
              roomName: 'Rooms',
              onTap: () {
                GoRouter.of(context).push(AppRoutes.rooms);
              },
              svgName: 'room',
            ),
            HomeControl(
              roomName: 'Kitchen',
              onTap: () {
                GoRouter.of(context).push(AppRoutes.kitchen);
              },
              svgName: 'kitchen',
            ),
            HomeControl(
              roomName: 'Fire Camera',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FireCam()),
                );
              },
              svgName: 'flame',
            ),
            HomeControl(
              roomName: 'Face Recognition',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FaceCam()),
                );
              },
              svgName: 'face',
            ),
          ],
        ),
      ),
    );
  }
}
