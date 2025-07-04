import 'package:flutter/material.dart';
import 'package:smart_home/core/theming/colors.dart';

import '../../../../core/theming/text_style.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          textColor: mainColor,
          leading: Icon(icon, size: 32, color: mainColor),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: mainColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(subtitle, style: TextStyles.font14GrayRegular),
        ),
        const SizedBox(height: 3),
        const Divider(thickness: 1, indent: 16, endIndent: 16),
        const SizedBox(height: 3),
      ],
    );
  }
}
