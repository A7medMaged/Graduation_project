import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_home/core/theming/text_style.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/signout_section.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/user_avatar.dart';
import 'package:smart_home/features/home_screen/presentation/widgets/user_details.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Avatar(),
          const SizedBox(height: 20),
          const Details(
            title: "Name",
            subtitle: "Ahmed Maged",
            icon: Icons.person,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.home, size: 32),
                  title: Text(
                    "Building No.",
                    style: TextStyles.font16WhiteMedium,
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    "17",
                    style: TextStyles.font14GrayRegular,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.apartment, size: 32),
                  title: Text(
                    "Apartment No.",
                    style: TextStyles.font16WhiteMedium,
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    "5",
                    style: TextStyles.font14GrayRegular,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
          const Divider(thickness: 1, indent: 16, endIndent: 16),
          const Details(
            title: "E-mail",
            subtitle: "ahmedmahmoud.work0@gmail.com",
            icon: Icons.email,
          ),
          const Details(
            title: "Phone",
            subtitle: "01154660193",
            icon: Icons.phone,
          ),
          const Details(
            title: "Role",
            subtitle: "User",
            icon: Icons.verified_user,
          ),
          Details(
            title: "Register Time",
            subtitle: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
            icon: Icons.access_time,
          ),
          const SignoutSection(),
        ],
      ),
    );
  }
}
