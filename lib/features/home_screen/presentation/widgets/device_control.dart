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
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        surfaceTintColor: isOn ? Colors.green : Colors.white,
        shadowColor: isOn ? Colors.green : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Icon(
              isOn ? iconOn : iconOff,
              color: isOn ? Colors.black : Colors.grey[600],
              size: 36,
            ),
            Text(
              deviceName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: isOn ? Colors.black : Colors.grey[600],
              ),
            ),
            SizedBox(width: 60),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  isOn ? Colors.green : Colors.red,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              child: Text(
                isOn ? textOn : textOff,
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
