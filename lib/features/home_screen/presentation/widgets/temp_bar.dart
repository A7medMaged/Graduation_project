import 'package:flutter/material.dart';
import 'package:smart_home/core/theming/colors.dart';

class TemperatureBar extends StatelessWidget {
  final int temperature;
  final Color color;

  const TemperatureBar({
    super.key,
    required this.temperature,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final clampedTemp = temperature.clamp(0, 100);
    final percent = clampedTemp / 100;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 80,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  height: 100 * percent,
                  width: 24,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Text(
              '$temperature°C',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Temperature', style: TextStyle(fontSize: 14, color: white)),
      ],
    );
  }
}
