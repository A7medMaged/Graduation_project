import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:smart_home/core/helper/connectivity_service.dart';
import 'package:smart_home/core/helper/notification_service.dart';
import 'package:smart_home/core/routing/router.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/firebase_options.dart';
import 'package:smart_home/smart_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityService.instance.initialize();

  try {
    await NotificationService().initializeNotification();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kDebugMode) {
      var logger = Logger(printer: PrettyPrinter());
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          logger.f('User is currently signed out!');
        } else {
          logger.f('User is signed in!');
        }
      });
    }

    runApp(SmartHomeApp(appRouter: AppRouter()));
  } catch (e) {
    if (kDebugMode) {
      Logger().e('Error initializing app: $e');
    }
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  kDebugMode ? 'Error: $e' : 'App failed to start',
                  style: const TextStyle(color: red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
