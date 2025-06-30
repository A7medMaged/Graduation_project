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

class FatherHomeScreen extends StatefulWidget {
  const FatherHomeScreen({super.key});

  @override
  State<FatherHomeScreen> createState() => _FatherHomeScreenState();
}

class _FatherHomeScreenState extends State<FatherHomeScreen> {
  Color _getTempColor(String temp) {
    final int? t = int.tryParse(temp);
    if (t == null) return Colors.grey;
    if (t <= 18) return Colors.blue;
    if (t <= 26) return Colors.orange;
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
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Temperature Section
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _getTempColor(
                                  state.tempSensor,
                                ).withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.thermostat_rounded,
                                color: _getTempColor(state.tempSensor),
                                size: 38,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${state.tempSensor}°C',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Temperature',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        // Divider
                        Container(
                          height: 60,
                          width: 1.5,
                          color: Colors.grey[300],
                        ),
                        // Humidity Section
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _getHumidityColor(
                                  state.humidity,
                                ).withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.water_drop_rounded,
                                color: _getHumidityColor(state.humidity),
                                size: 38,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${state.humidity}%',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            HomeControl(
              roomName: 'Kitchen',
              onTap: () {
                GoRouter.of(context).push(AppRoutes.kitchen);
              },
              svgName: 'kitchen',
            ),
            HomeControl(
              roomName: 'Rooms',
              onTap: () {
                GoRouter.of(context).push(AppRoutes.rooms);
              },
              svgName: 'room',
            ),
            HomeControl(
              roomName: 'Fire Camera',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FireCam()),
                );
              },
              svgName: 'flame',
            ),
            HomeControl(
              roomName: 'Face Recognition',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FaceCam()),
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
