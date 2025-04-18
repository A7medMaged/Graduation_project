import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          for (var i = 0; i < 7; i++)
            ListTile(
              leading: const CircleAvatar(),
              title: Container(
                height: 10,
                width: double.infinity,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 10,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
