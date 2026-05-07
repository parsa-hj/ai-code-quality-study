import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/auth_scaffold.dart';

class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create your FreshCart account',
      subtitle:
          'Save favorites, track every order, and keep checkout details ready across mobile and web.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sign up', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          AppTextField(
            hint: 'Full name',
            prefixIcon: Icons.person_outline,
            controller: controller.signupNameController,
          ),
          const SizedBox(height: 14),
          AppTextField(
            hint: 'Email address',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            controller: controller.signupEmailController,
          ),
          const SizedBox(height: 14),
          AppTextField(
            hint: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            controller: controller.signupPasswordController,
          ),
          const SizedBox(height: 16),
          Obx(
            () => AppButton(
              label: 'Create account',
              onPressed: controller.signup,
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account?'),
          TextButton(
            onPressed: () => Get.offNamed(AppRoutes.login),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
