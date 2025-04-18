import 'package:flutter/material.dart';
import 'package:smart_home/core/theming/text_style.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging,',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(text: ' ', style: TextStyles.font13LightGrayRegular),
          TextSpan(
            text: 'you agree to our',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(text: ' ', style: TextStyles.font13LightGrayRegular),
          TextSpan(
            text: ' terms and conditions',
            style: TextStyles.font13GrayRegular,
          ),
          TextSpan(text: ' ', style: TextStyles.font13LightGrayRegular),
          TextSpan(
            text: ' and',
            style: TextStyles.font13LightGrayRegular.copyWith(height: 1.6),
          ),
          TextSpan(text: ' ', style: TextStyles.font13LightGrayRegular),
          TextSpan(
            text: ' privacy policy',
            style: TextStyles.font13GrayRegular,
          ),
        ],
      ),
    );
  }
}
