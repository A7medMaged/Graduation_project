import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((_) {
                    GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
                    var logger = Logger(printer: PrettyPrinter());
                    logger.i('User signed out successfully!');
                  })
                  .catchError((error) {
                    var logger = Logger(printer: PrettyPrinter());
                    logger.e('Error signing out: $error');
                  });
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyles.font12BlueRegular,
        ),
      ),
    );
  }
}
