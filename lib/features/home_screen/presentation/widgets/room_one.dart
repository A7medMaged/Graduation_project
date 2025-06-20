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
        title: const Text('Room 1'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<LedsCubit, LedsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DeviceControl(
                  textOn: 'On',
                  textOff: 'Off',
                  isOn: state.room1Led,
                  iconOn: Icons.lightbulb,
                  iconOff: Icons.lightbulb_outline,
                  deviceName: 'Led',
                  onPressed: () {
                    context.read<LedsCubit>().toggleRoom1Led();
                  },
                ),
                const SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 32,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.thermostat,
                              color: _getTempColor(state.tempSensor),
                              size: 36,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.tempSensor}°C',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 32),
                        Column(
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: _getHumidityColor(state.humidity),
                              size: 36,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.humidity}%',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
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
