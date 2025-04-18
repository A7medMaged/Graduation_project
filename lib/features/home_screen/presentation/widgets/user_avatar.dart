import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset('assets/images/profile.png'),
    );
  }
}
