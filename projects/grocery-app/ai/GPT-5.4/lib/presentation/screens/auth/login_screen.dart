import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/auth_scaffold.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back to your curated market',
      subtitle:
          'Order produce, pantry staples, and daily essentials with a premium grocery experience designed for every screen.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Login', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          AppTextField(
            hint: 'Email address',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            controller: controller.loginEmailController,
          ),
          const SizedBox(height: 14),
          AppTextField(
            hint: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            controller: controller.loginPasswordController,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => AppButton(
              label: 'Login',
              onPressed: controller.login,
              isLoading: controller.isLoading.value,
            ),
          ),
          const SizedBox(height: 20),
          const _SocialRow(),
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('New here?'),
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.signup),
            child: const Text('Create account'),
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends GetView<AuthController> {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('or continue with'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => controller.socialLogin('Google'),
                icon: const Icon(Icons.g_mobiledata_rounded),
                label: const Text('Google'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => controller.socialLogin('Apple'),
                icon: const Icon(Icons.apple),
                label: const Text('Apple'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
