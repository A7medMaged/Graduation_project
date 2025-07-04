import 'package:flutter/material.dart';
import 'package:smart_home/core/theming/colors.dart';

class AppImageButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonImage;
  final VoidCallback onPressed;
  const AppImageButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(backgroundColor ?? lightBlue),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 12,
            vertical: verticalPadding ?? 14,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth ?? double.maxFinite, buttonHeight ?? 50),
        ),
      ),
      onPressed: onPressed,
      child: Image.asset(buttonImage, width: 20, height: 20),
    );
  }
}
