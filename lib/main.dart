import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Change from logger/web.dart
import 'package:smart_home/core/helper/notification_service.dart';
import 'package:smart_home/core/routing/router.dart';
import 'package:smart_home/firebase_options.dart';
import 'package:smart_home/smart_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    Logger().e('Error initializing app: $e');
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
