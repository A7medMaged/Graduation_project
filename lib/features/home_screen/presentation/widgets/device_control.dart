// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:smart_home/core/theming/colors.dart';

class DeviceControl extends StatelessWidget {
  final bool isOn;
  final IconData iconOn;
  final IconData iconOff;
  final String deviceName;
  final String textOn;
  final String textOff;
  final void Function()? onPressed;

  const DeviceControl({
    super.key,
    required this.isOn,
    required this.iconOn,
    required this.iconOff,
    required this.deviceName,
    required this.onPressed,
    required this.textOn,
    required this.textOff,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: secondary.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isOn ? mainColor.withOpacity(0.5) : grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isOn ? mainColor : red,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (isOn)
                        BoxShadow(
                          color: mainColor.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                    ],
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Icon(
                    isOn ? iconOn : iconOff,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      deviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: isOn ? mainColor : red,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isOn ? textOn : textOff,
                      style: TextStyle(
                        fontSize: 15,
                        color: isOn ? mainColor : red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Transform.scale(
              scale: 1.2,
              child: Switch.adaptive(
                value: isOn,
                onChanged: (_) => onPressed?.call(),
                activeColor: mainColor,
                activeTrackColor: mainColor.withOpacity(0.3),
                inactiveThumbColor: Colors.grey[400],
                inactiveTrackColor: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
