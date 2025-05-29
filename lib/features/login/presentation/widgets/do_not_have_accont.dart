import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/text_style.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(text: '  ', style: TextStyles.font13LightGrayRegular),
          TextSpan(
            text: 'Sign Up',
            style: TextStyles.font13BlueSemiBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).pushReplacement(AppRoutes.registerScreen);
              },
          ),
        ],
      ),
    );
  }
}
