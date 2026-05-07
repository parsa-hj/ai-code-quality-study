import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/auth_controller.dart';

/// Sign-up / registration screen.
class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.createAccount),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingXXL,
            vertical: AppSizes.paddingLG,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Name
                TextFormField(
                  controller: nameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: AppStrings.fullName,
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: Validators.name,
                ),
                const SizedBox(height: AppSizes.spacingLG),

                // Email
                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: AppStrings.email,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: Validators.email,
                ),
                const SizedBox(height: AppSizes.spacingLG),

                // Phone (optional)
                TextFormField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: AppStrings.phoneOptional,
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (v) =>
                      v != null && v.isNotEmpty ? Validators.phone(v) : null,
                ),
                const SizedBox(height: AppSizes.spacingLG),

                // Password
                Obx(
                  () => TextFormField(
                    controller: passwordCtrl,
                    obscureText: controller.obscurePassword.value,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(controller.obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: Validators.password,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingLG),

                // Confirm password
                Obx(
                  () => TextFormField(
                    controller: confirmCtrl,
                    obscureText: controller.obscureConfirmPassword.value,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: AppStrings.confirmPassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(controller.obscureConfirmPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    validator: (v) =>
                        Validators.confirmPassword(v, passwordCtrl.text),
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXXL),

                // Error
                Obx(
                  () => controller.errorMessage.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              bottom: AppSizes.spacingLG),
                          padding: const EdgeInsets.all(AppSizes.paddingMD),
                          decoration: BoxDecoration(
                            color: AppColors.errorLight,
                            borderRadius: BorderRadius.circular(
                                AppSizes.radiusMD),
                            border: Border.all(color: AppColors.error),
                          ),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: AppColors.error),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // Sign-up button
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.signup(
                                name: nameCtrl.text,
                                email: emailCtrl.text,
                                phone: phoneCtrl.text.isEmpty
                                    ? null
                                    : phoneCtrl.text,
                                password: passwordCtrl.text,
                              );
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
                        : const Text(AppStrings.createAccount),
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXL),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: Get.back,
                      child: const Text(AppStrings.login),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
