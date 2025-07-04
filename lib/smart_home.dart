import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:smart_home/core/helper/global_sensors_observer.dart';
import 'package:smart_home/core/routing/router.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/home_screen/data/repos/mode_repo.dart';
import 'package:smart_home/features/home_screen/data/repos/sensors_repo.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/leds_cubit/leds_cubit.dart';
import 'package:smart_home/features/home_screen/presentation/cubits/sensors_cubit/sensors_cubit.dart';

import 'features/home_screen/data/repos/leds_repo.dart';
import 'features/home_screen/presentation/cubits/mode_cubit/mode_cubit.dart';

class SmartHomeApp extends StatefulWidget {
  const SmartHomeApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<SmartHomeApp> createState() => _SmartHomeAppState();
}

class _SmartHomeAppState extends State<SmartHomeApp> {
  var logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SensorsCubit(SensorsRepo())..startMointring(),
        ),
        BlocProvider(create: (context) => ModeCubit(ModeRepo())),
        // Add this provider for LedsCubit
        BlocProvider(create: (context) => LedsCubit(LedsRepo())),
      ],
      child: GlobalSensorsObserver(
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Smart Home App',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: black,
            textTheme: GoogleFonts.exo2TextTheme(ThemeData.dark().textTheme),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
