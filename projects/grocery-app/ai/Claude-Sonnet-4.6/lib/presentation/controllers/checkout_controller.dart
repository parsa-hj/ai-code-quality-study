import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/core/services/auth_service.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/models/promo_code_model.dart';
import 'package:grocery_app/data/repositories/order_repository.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Manages checkout flow: address, delivery, payment, order placement.
class CheckoutController extends GetxController {
  final OrderRepository _orderRepository;
  final ProductRepository _productRepository;
  final AuthService _authService;

  CheckoutController(
    this._orderRepository,
    this._productRepository,
    this._authService,
  );

  // ─── State ────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool isPlacingOrder = false.obs;

  // Address
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);

  // Delivery
  final Rx<DeliveryOption> selectedDelivery = DeliveryOption.standard.obs;

  // Payment
  final RxString selectedPaymentMethod = 'Cash on Delivery'.obs;
  final RxList<String> savedPaymentMethods = <String>[
    'Visa •••• 4242',
    'Mastercard •••• 8765',
    'Cash on Delivery',
  ].obs;

  // Promo
  final Rx<PromoCodeModel?> appliedPromo = Rx<PromoCodeModel?>(null);
  final RxBool promoLoading = false.obs;
  final RxString promoError = ''.obs;

  // Order being placed
  final Rx<OrderModel?> placedOrder = Rx<OrderModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  // ─── Address ──────────────────────────────────────────────────────────────

  Future<void> loadAddresses() async {
    isLoading.value = true;
    try {
      final userId = _authService.currentUser.value?.id ?? '';
      addresses.value = await _orderRepository.getAddresses(userId);
      // Auto-select default
      try {
        selectedAddress.value =
            addresses.firstWhere((a) => a.isDefault);
      } catch (_) {
        if (addresses.isNotEmpty) selectedAddress.value = addresses.first;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void selectAddress(AddressModel address) =>
      selectedAddress.value = address;

  void selectDelivery(DeliveryOption option) =>
      selectedDelivery.value = option;

  void selectPayment(String method) =>
      selectedPaymentMethod.value = method;

  // ─── Promo Code ───────────────────────────────────────────────────────────

  Future<void> applyPromoCode(String code, double subtotal) async {
    if (code.trim().isEmpty) return;
    promoLoading.value = true;
    promoError.value = '';

    try {
      final promo = await _productRepository.validatePromoCode(code.trim());
      if (promo == null) {
        promoError.value = AppStrings.invalidPromoCode;
        appliedPromo.value = null;
      } else if (promo.minimumOrderAmount != null &&
          subtotal < promo.minimumOrderAmount!) {
        promoError.value =
            'Minimum order of ${Helpers.formatPrice(promo.minimumOrderAmount!)} required';
        appliedPromo.value = null;
      } else {
        appliedPromo.value = promo;
        Get.snackbar(
          'Promo applied!',
          promo.description,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: Colors.white,
        );
      }
    } finally {
      promoLoading.value = false;
    }
  }

  void removePromo() {
    appliedPromo.value = null;
    promoError.value = '';
  }

  // ─── Pricing ──────────────────────────────────────────────────────────────

  double deliveryFee(double subtotal) {
    if (subtotal >= AppConstants.freeDeliveryThreshold) return 0;
    switch (selectedDelivery.value) {
      case DeliveryOption.express:
        return AppConstants.expressDeliveryFee;
      case DeliveryOption.scheduled:
        return AppConstants.scheduledDeliveryFee;
      case DeliveryOption.standard:
      default:
        return AppConstants.standardDeliveryFee;
    }
  }

  double discountAmount(double subtotal) =>
      appliedPromo.value?.calculateDiscount(subtotal) ?? 0.0;

  double orderTotal(double subtotal) =>
      subtotal - discountAmount(subtotal) + deliveryFee(subtotal);

  // ─── Place Order ──────────────────────────────────────────────────────────

  Future<void> placeOrder(CartController cartController) async {
    if (selectedAddress.value == null) {
      Get.snackbar('Error', AppStrings.addressRequired,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white);
      return;
    }

    isPlacingOrder.value = true;
    try {
      final subtotal = cartController.subtotal;
      final fee = deliveryFee(subtotal);
      final discount = discountAmount(subtotal);
      final total = orderTotal(subtotal);
      final userId = _authService.currentUser.value?.id ?? '';

      final order = await _orderRepository.placeOrder(
        userId: userId,
        cartItems: cartController.items.toList(),
        deliveryAddress: selectedAddress.value!,
        subtotal: subtotal,
        discountAmount: discount,
        deliveryFee: fee,
        total: total,
        paymentMethod: selectedPaymentMethod.value,
        deliveryOption: selectedDelivery.value,
        promoCode: appliedPromo.value?.code,
      );

      placedOrder.value = order;
      cartController.clearCart();

      Get.offAllNamed(
        AppRoutes.orderSuccess,
        arguments: {'order': order},
      );
    } on AppException catch (e) {
      Get.snackbar('Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white);
    } catch (_) {
      Get.snackbar('Error', AppStrings.somethingWrong,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white);
    } finally {
      isPlacingOrder.value = false;
    }
  }
}
