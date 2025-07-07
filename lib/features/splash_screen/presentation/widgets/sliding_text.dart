import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/core/theming/text_style.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            'Welcome to HAVEN \n Your Safe, Smart & Connected Home',
            textAlign: TextAlign.center,
            style: TextStyles.font32BlueBold.copyWith(
              fontFamily: GoogleFonts.creepsterTextTheme(
                ThemeData.dark().textTheme,
              ).bodyLarge!.fontFamily,
              color: mainColor,
            ),
          ),
        );
      },
    );
  }
}
