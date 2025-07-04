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
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: secondary.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        // ignore: deprecated_member_use
        tileColor: secondary.withOpacity(0.85),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: SvgPicture.asset(
          'assets/svgs/$svgName.svg',
          colorFilter: const ColorFilter.mode(mainColor, BlendMode.srcIn),
          width: 38,
          height: 38,
          placeholderBuilder: (BuildContext context) => const Icon(Icons.error),
        ),
        title: Text(roomName, style: TextStyles.font16WhiteSemiBold),
        subtitle: Text(
          'Control your devices',
          style: TextStyles.font13WhiteRegular,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: white),
      ),
    );
  }
}
