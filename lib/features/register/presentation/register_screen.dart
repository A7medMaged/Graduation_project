import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:smart_home/core/helper/app_regex.dart';
import 'package:smart_home/core/routing/routes.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:smart_home/core/theming/text_style.dart';
import 'package:smart_home/core/widgets/app_text_form_field.dart';
import 'package:smart_home/features/register/data/cubit/register_cubit.dart';
import 'package:smart_home/features/register/presentation/widgets/back_to_login.dart';
import 'package:toastification/toastification.dart';
import 'package:easy_stepper/easy_stepper.dart';
import '../../../core/widgets/app_text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  int activeStep = 0;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final buildingNoController = TextEditingController();
  final apartmentNoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final logger = Logger();
  bool isObscureText1 = true;
  bool isObscureText2 = true;
  String _selectedRole = 'father';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              EasyStepper(
                activeStep: activeStep,
                lineStyle: const LineStyle(
                  lineLength: 60,
                  activeLineColor: mainColor,
                  finishedLineColor: mainColor,
                  lineThickness: 1.5,
                  defaultLineColor: mainColor,
                ),
                stepShape: StepShape.circle,
                stepRadius: 32,
                showLoadingAnimation: false,
                activeStepIconColor: mainColor,
                activeStepTextColor: white,
                activeStepBorderColor: mainColor,
                finishedStepIconColor: mainColor,
                finishedStepBorderColor: mainColor,
                finishedStepBackgroundColor: Colors.transparent,
                finishedStepTextColor: white,
                steps: const [
                  EasyStep(icon: Icon(Icons.person), title: 'Personal'),
                  EasyStep(icon: Icon(Icons.lock), title: 'Account'),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: activeStep == 0
                          ? _buildPersonalInfo()
                          : _buildAccountInfo(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 75,
                    child: activeStep > 0
                        ? AppTextButton(
                            onPressed: () => setState(() => activeStep--),
                            child: const Text(
                              'Back',
                              style: TextStyle(color: mainColor, fontSize: 21),
                            ),
                          )
                        : const Icon(
                            Icons.arrow_circle_right,
                            size: 32,
                            color: mainColor,
                          ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Align(
                      child: BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            toastification.show(
                              context: context,
                              title: const Text('Registration Successful'),
                              description: const Text(
                                'Your account has been created successfully.\nGo to your email to verify your account.',
                              ),
                              type: ToastificationType.success,
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                            GoRouter.of(
                              context,
                            ).pushReplacement(AppRoutes.loginScreen);
                          } else if (state is RegisterFailure) {
                            toastification.show(
                              context: context,
                              title: Text(state.error),
                              description: const Text(
                                'Error occurred while creating account. Please try again.',
                              ),
                              type: ToastificationType.error,
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                          }
                        },
                        builder: (context, state) {
                          return AppTextButton(
                            child: (state is RegisterLoading)
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: GFLoader(type: GFLoaderType.ios),
                                  )
                                : Text(
                                    activeStep == 1 ? 'Submit' : 'Next',
                                    style: const TextStyle(
                                      color: mainColor,
                                      fontSize: 21,
                                    ),
                                  ),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;

                              if (activeStep == 0) {
                                setState(() => activeStep++);
                              } else {
                                context.read<RegisterCubit>().register(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  role: _selectedRole,
                                  buildingNo:
                                      int.tryParse(
                                        buildingNoController.text.trim(),
                                      ) ??
                                      0,
                                  apartmentNo:
                                      int.tryParse(
                                        apartmentNoController.text.trim(),
                                      ) ??
                                      0,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Center(child: BackToLoginScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Role', style: TextStyles.font24BlueBold),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          hint: const Text('Select Role'),
          value: _selectedRole,
          items: ['father', 'mother', 'child']
              .map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              )
              .toList(),
          onChanged: (value) => setState(() => _selectedRole = value!),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Building No.', style: TextStyles.font16BlueSemiBold),
                  const SizedBox(height: 8),
                  AppTextFormField(
                    controller: buildingNoController,
                    hintText: 'Building No.',
                    prefixIcon: const Icon(FontAwesomeIcons.building),
                    keyboardType: TextInputType.number,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Enter building no'
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Apartment No.', style: TextStyles.font16BlueSemiBold),
                  const SizedBox(height: 8),
                  AppTextFormField(
                    // Remove Expanded from here
                    controller: apartmentNoController,
                    hintText: 'Apartment No.',
                    prefixIcon: const Icon(FontAwesomeIcons.doorOpen),
                    keyboardType: TextInputType.number,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Enter apartment no'
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text('Name', style: TextStyles.font24BlueBold),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: nameController,
          hintText: 'Enter your name',
          prefixIcon: const Icon(FontAwesomeIcons.user),
          keyboardType: TextInputType.name,
          validator: (value) => (value == null || value.isEmpty)
              ? 'Please enter your name'
              : null,
        ),
        const SizedBox(height: 18),
        Text('Phone', style: TextStyles.font24BlueBold),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: phoneController,
          hintText: 'Enter your phone number',
          prefixIcon: const Icon(FontAwesomeIcons.phone),
          keyboardType: TextInputType.phone,
          validator: (value) =>
              (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberValid(value))
              ? 'Please enter your phone number'
              : null,
        ),
      ],
    );
  }

  Widget _buildAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('E-mail', style: TextStyles.font24BlueBold),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: emailController,
          hintText: 'Enter your e-mail',
          prefixIcon: const Icon(FontAwesomeIcons.envelope),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !AppRegex.isEmailValid(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 18),
        Text('Password', style: TextStyles.font24BlueBold),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: passwordController,
          hintText: 'Enter your password',
          isObscureText: isObscureText1,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => isObscureText1 = !isObscureText1),
            child: Icon(
              isObscureText1 ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            ),
          ),
          prefixIcon: const Icon(FontAwesomeIcons.key),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) =>
              (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPasswordValid(value))
              ? 'Please enter a valid password'
              : null,
        ),
        const SizedBox(height: 18),
        Text('Confirm Password', style: TextStyles.font24BlueBold),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: confirmPasswordController,
          hintText: 'Re-enter your password',
          isObscureText: isObscureText2,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => isObscureText2 = !isObscureText2),
            child: Icon(
              isObscureText2 ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            ),
          ),
          prefixIcon: const Icon(FontAwesomeIcons.key),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please re-enter your password';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }
}
