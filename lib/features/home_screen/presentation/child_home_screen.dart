import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_state.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/home_control.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/humidity_progress.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/temp_bar.dart';

class ChildHomeScreen extends StatefulWidget {
  const ChildHomeScreen({super.key});

  @override
  State<ChildHomeScreen> createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  Color _getTempColor(int temp) {
    if (temp < 25) return Colors.blue;
    if (temp < 30) return Colors.orange;
    return Colors.red;
  }

  Color _getHumidityColor(int humidity) {
    if (humidity < 30) return Colors.blue;
    if (humidity < 60) return Colors.orange;
    return red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        backgroundColor: secondary.withOpacity(0.85),
        title: const Text('Welcome Back'),
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
      body: Stack(
        children: [
          Image.asset('assets/images/living.jpg', fit: BoxFit.cover),
          // ignore: deprecated_member_use
          Container(color: secondary.withOpacity(0.4)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 16,
              children: [
                BlocBuilder<LedsCubit, LedsState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(
                        child: Skeletonizer(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: secondary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: grey.withOpacity(0.2),
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
                                  temperature: 25,
                                  color: _getTempColor(state.tempSensor),
                                ),
                                Container(
                                  height: 70,
                                  width: 1.2,
                                  color: Colors.grey[300],
                                ),
                                HumidityProgress(
                                  humidity: 45,
                                  color: _getHumidityColor(state.humidity),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: secondary.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: grey.withOpacity(0.2),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
