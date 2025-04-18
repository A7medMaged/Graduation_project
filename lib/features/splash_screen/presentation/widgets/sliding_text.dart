import 'package:flutter/material.dart';
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
            'Be Smarter',
            textAlign: TextAlign.center,
            style: TextStyles.font32BlueBold,
          ),
        );
      },
    );
  }
}
