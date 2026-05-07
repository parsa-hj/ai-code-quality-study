import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/core/services/auth_service.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/data/repositories/auth_repository.dart';
import 'package:grocery_app/data/repositories/order_repository.dart';
import 'package:grocery_app/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

/// Manages user profile, addresses, notifications, settings.
class ProfileController extends GetxController {
  final AuthService _authService;
  final OrderRepository _orderRepository;

  ProfileController(this._authService, this._orderRepository);

  static const _uuid = Uuid();

  // ─── State ────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  // User
  Rx<UserModel?> get currentUser => _authService.currentUser;

  // Addresses
  final RxList<AddressModel> addresses = <AddressModel>[].obs;

  // Notification settings
  final RxBool orderUpdates = true.obs;
  final RxBool promotions = true.obs;
  final RxBool reminders = false.obs;
  final RxBool emailNotifications = true.obs;
  final RxBool smsNotifications = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAddresses();
    _loadNotificationPrefs();
  }

  // ─── Profile ──────────────────────────────────────────────────────────────

  Future<void> updateProfile({
    required String name,
    String? phone,
  }) async {
    isSaving.value = true;
    try {
      final authRepo = Get.find<AuthRepository>();
      await authRepo.updateProfile(name: name, phone: phone);
      Get.snackbar(
        'Success',
        AppStrings.profileUpdated,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } catch (_) {
      Get.snackbar('Error', AppStrings.somethingWrong,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white);
    } finally {
      isSaving.value = false;
    }
  }

  // ─── Addresses ────────────────────────────────────────────────────────────

  Future<void> _loadAddresses() async {
    final userId = _authService.currentUser.value?.id ?? '';
    addresses.value = await _orderRepository.getAddresses(userId);
  }

  Future<void> addAddress({
    required String label,
    required String name,
    required String phone,
    required String line1,
    String? line2,
    required String city,
    required String state,
    required String postalCode,
  }) async {
    isSaving.value = true;
    try {
      final address = AddressModel(
        id: 'addr_${_uuid.v4().substring(0, 8)}',
        label: label,
        recipientName: name,
        phone: phone,
        addressLine1: line1,
        addressLine2: line2,
        city: city,
        state: state,
        postalCode: postalCode,
        isDefault: addresses.isEmpty,
      );
      final userId = _authService.currentUser.value?.id ?? '';
      await _orderRepository.addAddress(userId: userId, address: address);
      addresses.add(address);
      Get.back();
      Get.snackbar(
        'Added',
        AppStrings.addressAdded,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteAddress(String addressId) async {
    await _orderRepository.deleteAddress(addressId);
    addresses.removeWhere((a) => a.id == addressId);
    Get.snackbar(
      'Deleted',
      AppStrings.addressDeleted,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
    );
  }

  Future<void> setDefaultAddress(String addressId) async {
    await _orderRepository.setDefaultAddress(addressId);
    for (int i = 0; i < addresses.length; i++) {
      addresses[i] = addresses[i].copyWith(isDefault: addresses[i].id == addressId);
    }
    addresses.refresh();
  }

  // ─── Notifications ────────────────────────────────────────────────────────

  void _loadNotificationPrefs() {
    final storage = Get.find<StorageService>();
    orderUpdates.value =
        storage.getBool(AppConstants.keyOrderUpdates, defaultValue: true);
    promotions.value =
        storage.getBool(AppConstants.keyPromotions, defaultValue: true);
    reminders.value =
        storage.getBool(AppConstants.keyReminders, defaultValue: false);
    emailNotifications.value =
        storage.getBool(AppConstants.keyEmailNotifications, defaultValue: true);
    smsNotifications.value =
        storage.getBool(AppConstants.keySmsNotifications, defaultValue: false);
  }

  void toggleOrderUpdates(bool value) {
    orderUpdates.value = value;
    Get.find<StorageService>().setBool(AppConstants.keyOrderUpdates, value);
  }

  void togglePromotions(bool value) {
    promotions.value = value;
    Get.find<StorageService>().setBool(AppConstants.keyPromotions, value);
  }

  void toggleReminders(bool value) {
    reminders.value = value;
    Get.find<StorageService>().setBool(AppConstants.keyReminders, value);
  }

  void toggleEmailNotifications(bool value) {
    emailNotifications.value = value;
    Get.find<StorageService>()
        .setBool(AppConstants.keyEmailNotifications, value);
  }

  void toggleSmsNotifications(bool value) {
    smsNotifications.value = value;
    Get.find<StorageService>().setBool(AppConstants.keySmsNotifications, value);
  }

  // ─── Logout ───────────────────────────────────────────────────────────────

  Future<void> logout() async {
    await _authService.clearSession();
    Get.offAllNamed(AppRoutes.login);
  }
}
