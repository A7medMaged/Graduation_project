import 'package:flutter/material.dart';

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
          leading: Icon(icon, size: 32),
          title: Text(title, style: TextStyles.font16WhiteMedium),
          subtitle: Text(subtitle, style: TextStyles.font14GrayRegular),
        ),
        const SizedBox(height: 3),
        const Divider(thickness: 1, indent: 16, endIndent: 16),
        const SizedBox(height: 3),
      ],
    );
  }
}
