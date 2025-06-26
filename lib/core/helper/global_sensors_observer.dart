import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/core/helper/notification_service.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_state.dart';

class GlobalSensorsObserver extends StatefulWidget {
  final Widget child;

  const GlobalSensorsObserver({super.key, required this.child});

  @override
  State<GlobalSensorsObserver> createState() => _GlobalSensorsObserverState();
}

class _GlobalSensorsObserverState extends State<GlobalSensorsObserver> {
  final NotificationService _notificationService = NotificationService();
  bool _previousGasState = false;
  bool _previousFlameState = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SensorsCubit, SensorsState>(
      listener: (context, state) {
        // Only notify if state changes from false to true
        if (state.gasDetected && !_previousGasState) {
          _notificationService.showNotification(
            body: 'Gas Detected! Please take action immediately.',
          );
        }

        if (state.flameDetected && !_previousFlameState) {
          _notificationService.showNotification(
            body: 'Fire Detected! Please take action immediately.',
          );
        }

        // Update previous states
        _previousGasState = state.gasDetected;
        _previousFlameState = state.flameDetected;
      },
      child: widget.child,
    );
  }
}
