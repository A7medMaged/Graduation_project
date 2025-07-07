// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:smart_home/core/helper/connectivity_service.dart';
import 'package:smart_home/core/helper/global_sensors_observer.dart';
import 'package:smart_home/core/routing/router.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/data/repos/leds_repo.dart';
import 'package:smart_home/features/home_screen/data/repos/mode_repo.dart';
import 'package:smart_home/features/home_screen/data/repos/sensors_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/mode_cubit/mode_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_cubit.dart';

class SmartHomeApp extends StatefulWidget {
  const SmartHomeApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<SmartHomeApp> createState() => _SmartHomeAppState();
}

class _SmartHomeAppState extends State<SmartHomeApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SensorsCubit(SensorsRepo())..startMointring(),
        ),
        BlocProvider(create: (context) => ModeCubit(ModeRepo())),
        BlocProvider(create: (context) => LedsCubit(LedsRepo())),
      ],
      child: GlobalSensorsObserver(
        child: MaterialApp.router(
          title: 'Smart Home',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: black,
            textTheme: GoogleFonts.exo2TextTheme(ThemeData.dark().textTheme),
          ),
          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return Material(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          kDebugMode
                              ? 'Error: ${errorDetails.exception}'
                              : 'Something went wrong',
                          style: const TextStyle(color: red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            };
            return StreamBuilder<InternetStatus>(
              stream: ConnectivityService.instance.stream,
              builder: (context, snapshot) {
                final isDisconnected =
                    snapshot.data == InternetStatus.disconnected;
                return Stack(
                  children: [
                    child ?? const SizedBox(),
                    if (isDisconnected)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                mainColor,
                                mainColor.withOpacity(0.7),
                                mainColor.withOpacity(0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: const Center(
                            child: Card(
                              margin: EdgeInsets.all(16),
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.wifi_off, size: 48, color: red),
                                    SizedBox(height: 16),
                                    Text(
                                      'No Internet Connection',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please check your connection and try again.',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 24),
                                    GFLoader(
                                      type: GFLoaderType.circle,
                                      loaderColorOne: red,
                                      loaderColorTwo: red,
                                      loaderColorThree: red,
                                      loaderstrokeWidth: 2.0,
                                      size: GFSize.LARGE,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
