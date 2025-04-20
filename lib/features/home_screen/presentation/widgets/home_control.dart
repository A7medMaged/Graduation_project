import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/core/theming/text_style.dart';

class HomeControl extends StatelessWidget {
  const HomeControl({
    super.key,
    required this.roomName,
    required this.onTap,
    required this.svgName,
  });
  final String roomName;
  final void Function()? onTap;
  final String svgName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: SvgPicture.asset(
        'assets/svgs/$svgName.svg',
        width: 38,
        height: 38,
        placeholderBuilder: (BuildContext context) => const Icon(Icons.error),
      ),
      title: Text(roomName, style: TextStyles.font18BlackBold),
      subtitle: Text(
        'Control your devices',
        style: TextStyles.font13GrayRegular,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: black),
    );
  }
}
