import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/auth_scaffold.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Reset your password',
      subtitle:
          'Enter the email linked to your account and we will send recovery instructions.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Forgot password', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          AppTextField(
            hint: 'Email address',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            controller: controller.forgotEmailController,
          ),
          const SizedBox(height: 16),
          Obx(
            () => AppButton(
              label: 'Send reset link',
              onPressed: controller.sendResetLink,
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
