import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/auth_controller.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Login screen.
class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isDark = context.isDark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingXXL,
            vertical: AppSizes.paddingXL,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spacingXL),
                // Header
                Text(
                  AppStrings.welcomeBack,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSizes.spacingSM),
                Text(
                  AppStrings.loginSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSizes.spacingXXXL),

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

                // Password
                Obx(
                  () => TextFormField(
                    controller: passwordCtrl,
                    obscureText: controller.obscurePassword.value,
                    textInputAction: TextInputAction.done,
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
                    onFieldSubmitted: (_) {
                      if (formKey.currentState?.validate() ?? false) {
                        controller.login(emailCtrl.text, passwordCtrl.text);
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.spacingSM),

                // Remember me + Forgot password
                Row(
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: (v) =>
                                  controller.rememberMe.value = v ?? false,
                              activeColor: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppSizes.spacingSM),
                          Text(
                            AppStrings.rememberMe,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () =>
                          Get.toNamed(AppRoutes.forgotPassword),
                      child: const Text(AppStrings.forgotPassword),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacingXXL),

                // Error message
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
                            style: const TextStyle(
                              color: AppColors.error,
                              fontSize: AppSizes.fontSM,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // Login button
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.login(
                                  emailCtrl.text, passwordCtrl.text);
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
                        : const Text(AppStrings.login),
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXL),

                // Demo credentials hint
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingMD),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurface
                        : AppColors.grey100,
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusMD),
                    border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.grey200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Demo Account',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppConstants.demoEmail,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        AppConstants.demoPassword,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXXXL),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.signup),
                      child: const Text(AppStrings.signUp),
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
