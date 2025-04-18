// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/features/splash_screen/presentation/splash_screen.dart';

class SmartHomeApp extends StatefulWidget {
  const SmartHomeApp({super.key});

  @override
  State<SmartHomeApp> createState() => _SmartHomeAppState();
}

class _SmartHomeAppState extends State<SmartHomeApp> {
  var logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: MaterialApp(
        home: SplashScreen(),
        title: 'Smart Home App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: black,
          textTheme: GoogleFonts.josefinSansTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
