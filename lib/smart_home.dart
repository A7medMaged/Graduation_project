// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:smart_home/core/routing/router.dart';
import 'package:smart_home/core/theming/colors.dart';

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
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Smart Home App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: black,
          textTheme: GoogleFonts.exo2TextTheme(ThemeData.dark().textTheme),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
