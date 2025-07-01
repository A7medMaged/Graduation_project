import 'package:flutter/material.dart';

class HumidityProgress extends StatelessWidget {
  final int humidity;
  final Color color;

  const HumidityProgress({
    super.key,
    required this.humidity,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double value = humidity.clamp(0, 100) / 100;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 6,
                // ignore: deprecated_member_use
                backgroundColor: color.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              '$humidity%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Humidity',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
