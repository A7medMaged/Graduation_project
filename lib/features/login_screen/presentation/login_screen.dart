import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home/core/helper/app_regex.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/core/theming/text_style.dart';
import 'package:smart_home/core/widgets/app_text_button.dart';
import 'package:smart_home/core/widgets/app_text_form_field.dart';
import 'package:smart_home/features/login_screen/presentation/widgets/do_not_have_accont.dart';
import 'package:smart_home/features/login_screen/presentation/widgets/terms_condition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var logger = Logger(printer: PrettyPrinter());
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/smart-house.png',
                  width: 100.w,
                  height: 100.h,
                  color: white,
                ),
                SizedBox(height: 40.h),
                Text('Welcome Back', style: TextStyles.font24BlueBold),
                SizedBox(height: 20.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('E-mail', style: TextStyles.font24BlueBold),
                      SizedBox(height: 8.h),
                      AppTextFormField(
                        controller: _emailController,
                        hintText: 'Enter your e-mail',
                        suffixIcon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !AppRegex.isEmailValid(value)) {
                            return 'Please enter a valid e-mail';
                          }
                        },
                      ),
                      SizedBox(height: 18.h),
                      Text('Password', style: TextStyles.font24BlueBold),
                      SizedBox(height: 8.h),
                      AppTextFormField(
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        isObscureText: isObscureText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(
                            isObscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                        },
                      ),
                      SizedBox(height: 18.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () {
                            // FirebaseAuth.instance.sendPasswordResetEmail(
                            //   email: _emailController.text.trim(),
                            // );
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyles.font12BlueRegular,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      AppTextButton(
                        buttonText: "Sign In",
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          GoRouter.of(context).push(AppRoutes.homeScreen);
                        },
                      ),
                      SizedBox(height: 16.h),
                      const TermsAndConditionsText(),
                      SizedBox(height: 40.h),
                      const Center(child: DontHaveAccountText()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> loginUser() async {
  //   // ignore: unused_local_variable
  //   UserCredential user =

  // }
}
