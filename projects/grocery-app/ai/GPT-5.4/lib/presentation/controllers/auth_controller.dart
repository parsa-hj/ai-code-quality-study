import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  final AuthRepository _authRepository;

  final loginEmailController = TextEditingController(text: 'alex@example.com');
  final loginPasswordController = TextEditingController(text: 'password123');
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final forgotEmailController = TextEditingController();

  final isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    await _authRepository.login(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text.trim(),
    );
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> signup() async {
    isLoading.value = true;
    await _authRepository.signup(
      name: signupNameController.text.trim(),
      email: signupEmailController.text.trim(),
      password: signupPasswordController.text.trim(),
    );
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> sendResetLink() async {
    isLoading.value = true;
    await _authRepository.resetPassword(forgotEmailController.text.trim());
    isLoading.value = false;
    Get.snackbar('Email sent', 'Password recovery instructions have been sent.');
    Get.back();
  }

  void socialLogin(String provider) {
    Get.snackbar('Coming soon', '$provider login is a placeholder in this demo.');
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    forgotEmailController.dispose();
    super.onClose();
  }
}
