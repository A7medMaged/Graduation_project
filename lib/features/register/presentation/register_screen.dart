import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:smart_home/core/helper/app_regex.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/text_style.dart';
import 'package:smart_home/core/widgets/app_text_form_field.dart';
import 'package:smart_home/features/register/data/cubit/register_cubit.dart';
import 'package:smart_home/features/register/presentation/widgets/back_to_login.dart';
import 'package:toastification/toastification.dart';

import '../../../core/widgets/app_text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var logger = Logger(printer: PrettyPrinter());
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String _selectedRole = 'father';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('Register', style: TextStyles.font32BlueBold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'We wish you a good day, please fill in the form to create an account',
                    style: TextStyles.font14LightGrayRegular,
                  ),
                  SizedBox(height: 36.h),
                  Text('Role', style: TextStyles.font24BlueBold),
                  SizedBox(height: 8.h),
                  DropdownButtonFormField<String>(
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    hint: const Text('Select Role'),
                    value: _selectedRole,
                    items:
                        ['father', 'mother', 'son', 'daughter'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      _selectedRole = value!;
                    },
                  ),
                  SizedBox(height: 18),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: TextStyles.font24BlueBold),
                        SizedBox(height: 8),
                        AppTextFormField(
                          controller: nameController,
                          hintText: 'Enter your name',
                          suffixIcon: const Icon(Icons.person_outline),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                        ),
                        SizedBox(height: 18),
                        Text('Phone Number', style: TextStyles.font24BlueBold),
                        SizedBox(height: 8),
                        AppTextFormField(
                          controller: phoneController,
                          hintText: 'Enter your phone number',
                          suffixIcon: const Icon(Icons.phone_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                          },
                        ),
                        SizedBox(height: 18),
                        Text('E-mail', style: TextStyles.font24BlueBold),
                        SizedBox(height: 8),
                        AppTextFormField(
                          controller: emailController,
                          hintText: 'Enter your e-mail',
                          suffixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !AppRegex.isEmailValid(value)) {
                              return 'Please enter a valid email';
                            }
                          },
                        ),
                        SizedBox(height: 18),
                        Text('Password', style: TextStyles.font24BlueBold),
                        SizedBox(height: 8),
                        AppTextFormField(
                          controller: passwordController,
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
                        SizedBox(height: 40.h),
                        BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterSuccess) {
                              GoRouter.of(context).go(AppRoutes.loginScreen);
                            } else if (state is RegisterFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return AppTextButton(
                              buttonText: "Sign Up",
                              textStyle: TextStyles.font16WhiteSemiBold,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<RegisterCubit>().register(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: nameController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    role: _selectedRole,
                                  );
                                  toastification.show(
                                    context: context,
                                    title: const Text('Success!'),
                                    description: const Text(
                                      'Account created successfully!',
                                    ),
                                    type: ToastificationType.success,
                                    style: ToastificationStyle.flat,
                                    autoCloseDuration: const Duration(
                                      seconds: 5,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        const Center(child: BackToLoginScreen()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
