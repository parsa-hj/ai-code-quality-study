import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/address_model.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../routes/app_routes.dart';
import 'theme_controller.dart';

class ProfileController extends GetxController {
  ProfileController(
    this._profileRepository,
    this._orderRepository,
    this._themeController,
  );

  final ProfileRepository _profileRepository;
  final OrderRepository _orderRepository;
  final ThemeController _themeController;

  final isLoading = true.obs;
  final notificationsEnabled = true.obs;
  final profile = Rxn<UserProfileModel>();
  final addresses = <AddressModel>[].obs;
  final paymentMethods = <PaymentMethodModel>[].obs;

  bool get isDarkMode => _themeController.themeMode == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    final results = await Future.wait<dynamic>([
      _profileRepository.getProfile(),
      _orderRepository.getAddresses(),
      _orderRepository.getPaymentMethods(),
    ]);
    profile.value = results[0] as UserProfileModel;
    addresses.assignAll(results[1] as List<AddressModel>);
    paymentMethods.assignAll(results[2] as List<PaymentMethodModel>);
    isLoading.value = false;
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  Future<void> toggleTheme(bool value) {
    return _themeController.toggleTheme(value);
  }

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }
}
