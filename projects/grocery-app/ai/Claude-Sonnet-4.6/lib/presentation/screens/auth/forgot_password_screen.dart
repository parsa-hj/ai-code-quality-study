import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/auth_controller.dart';

/// Forgot password screen.
class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.forgotPassword)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingXXL),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spacingXL),
                const Icon(Icons.lock_reset, size: 64, color: AppColors.primary),
                const SizedBox(height: AppSizes.spacingXL),
                Text(
                  AppStrings.forgotPasswordTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSizes.spacingSM),
                Text(
                  AppStrings.forgotPasswordSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSizes.spacingXXXL),
                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: AppStrings.email,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: Validators.email,
                ),
                const SizedBox(height: AppSizes.spacingXXL),

                // Error
                Obx(
                  () => controller.errorMessage.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: AppSizes.spacingLG),
                          padding: const EdgeInsets.all(AppSizes.paddingMD),
                          decoration: BoxDecoration(
                            color: AppColors.errorLight,
                            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                            border: Border.all(color: AppColors.error),
                          ),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: AppColors.error),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.forgotPassword(emailCtrl.text);
                            }
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text(AppStrings.sendResetLink),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
