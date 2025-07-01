import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home/core/helper/app_regex.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/core/theming/text_style.dart';
import 'package:smart_home/core/widgets/app_text_button.dart';
import 'package:smart_home/core/widgets/app_text_form_field.dart';
import 'package:smart_home/features/login/data/cubit/login_cubit.dart';
import 'package:smart_home/features/login/presentation/widgets/do_not_have_accont.dart';
import 'package:smart_home/features/login/presentation/widgets/terms_condition.dart';
import 'package:toastification/toastification.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('E-mail', style: TextStyles.font24BlueBold),
                      SizedBox(height: 8.h),
                      AppTextFormField(
                        controller: _emailController,
                        hintText: 'Enter your e-mail',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.envelope,
                          color: white,
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                          ),
                        ),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.key,
                          color: white,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !AppRegex.isPasswordValid(value)) {
                            return 'Please enter a valid password';
                          }
                        },
                      ),
                      SizedBox(height: 18.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                    email: _emailController.text.trim(),
                                  );
                              toastification.show(
                                // ignore: use_build_context_synchronously
                                context: context,
                                title: const Text('Warning!'),
                                description: const Text(
                                  'Password reset email sent',
                                ),
                                type: ToastificationType.warning,
                                style: ToastificationStyle.flat,
                                autoCloseDuration: const Duration(seconds: 5),
                              );
                            } on FirebaseAuthException catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: ${e.message}")),
                              );
                            }
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyles.font12BlueRegular,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            GoRouter.of(
                              context,
                            ).pushReplacement(AppRoutes.homeScreen);
                          } else if (state is LoginFailure) {
                            toastification.show(
                              context: context,
                              title: const Text('Login Failed'),
                              description: Text(state.error),
                              type: ToastificationType.error,
                              style: ToastificationStyle.flat,
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppTextButton(
                            buttonText: "Sign In",
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  autovalidateMode =
                                      AutovalidateMode.onUserInteraction;
                                });
                                try {
                                  context.read<LoginCubit>().login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  // ignore: unused_local_variable
                                  String errorMessage;
                                  switch (e.code) {
                                    case 'invalid-email':
                                      errorMessage =
                                          'The email address is not valid.';
                                      break;
                                    case 'user-disabled':
                                      errorMessage =
                                          'The user account has been disabled.';
                                      break;
                                    case 'user-not-found':
                                      errorMessage =
                                          'No user found with this email.';
                                      break;
                                    case 'wrong-password':
                                      errorMessage = 'Incorrect password.';
                                      break;
                                    default:
                                      errorMessage =
                                          'An unknown error occurred.';
                                  }
                                  toastification.show(
                                    context: context,
                                    title: const Text('Login Failed'),
                                    description: Text(errorMessage),
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flat,
                                    autoCloseDuration: const Duration(
                                      seconds: 5,
                                    ),
                                  );
                                } catch (e) {
                                  logger.e(e);
                                }
                              } else {
                                logger.e('Form is not valid');
                              }
                            },
                          );
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
