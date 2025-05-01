import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:smart_home/core/helper/notification_service.dart';
import 'package:smart_home/core/routing/router.dart';
import 'package:smart_home/firebase_options.dart';
import 'package:smart_home/smart_home.dart';

void main() async {
  var logger = Logger(printer: PrettyPrinter());
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializeNotification();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      logger.f('User is currently signed out!');
    } else {
      logger.f('User is signed in!');
    }
  });

  runApp(SmartHomeApp(appRouter: AppRouter()));
}
