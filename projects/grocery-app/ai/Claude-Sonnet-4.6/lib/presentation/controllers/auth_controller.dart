import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/data/repositories/auth_repository.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Handles login, signup, and forgot password flows.
class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  // ─── State ────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool rememberMe = false.obs;

  // ─── Actions ──────────────────────────────────────────────────────────────

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void toggleConfirmPasswordVisibility() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void clearError() => errorMessage.value = '';

  /// Logs in with email and password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (isLoading.value) return;
    errorMessage.value = '';
    isLoading.value = true;

    try {
      await _authRepository.login(email: email, password: password);
      Get.offAllNamed(AppRoutes.main);
      Get.snackbar(
        'Welcome back!',
        'You have logged in successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = AppStrings.somethingWrong;
    } finally {
      isLoading.value = false;
    }
  }

  /// Creates a new account.
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    if (isLoading.value) return;
    errorMessage.value = '';
    isLoading.value = true;

    try {
      await _authRepository.signup(
          name: name, email: email, password: password);
      Get.offAllNamed(AppRoutes.main);
      Get.snackbar(
        'Account created!',
        'Welcome to GroceryGo.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = AppStrings.somethingWrong;
    } finally {
      isLoading.value = false;
    }
  }

  /// Sends a password reset email.
  Future<bool> forgotPassword({required String email}) async {
    if (isLoading.value) return false;
    errorMessage.value = '';
    isLoading.value = true;

    try {
      await _authRepository.forgotPassword(email: email);
      return true;
    } on AppException catch (e) {
      errorMessage.value = e.message;
      return false;
    } catch (_) {
      errorMessage.value = AppStrings.somethingWrong;
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
