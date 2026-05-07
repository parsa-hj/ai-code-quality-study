import 'package:get/get.dart';

import '../../data/models/address_model.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/repositories/order_repository.dart';
import '../../routes/app_routes.dart';
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  CheckoutController(this._orderRepository, this._cartController);

  final OrderRepository _orderRepository;
  final CartController _cartController;

  final isLoading = true.obs;
  final addresses = <AddressModel>[].obs;
  final paymentMethods = <PaymentMethodModel>[].obs;
  final selectedAddressId = ''.obs;
  final selectedPaymentId = ''.obs;
  final deliveryOption = 'Priority'.obs;

  @override
  void onInit() {
    super.onInit();
    loadCheckoutData();
  }

  Future<void> loadCheckoutData() async {
    isLoading.value = true;
    final results = await Future.wait<dynamic>([
      _orderRepository.getAddresses(),
      _orderRepository.getPaymentMethods(),
    ]);
    addresses.assignAll(results[0] as List<AddressModel>);
    paymentMethods.assignAll(results[1] as List<PaymentMethodModel>);
    selectedAddressId.value =
        addresses.firstWhere((item) => item.isDefault).id;
    selectedPaymentId.value =
        paymentMethods.firstWhere((item) => item.isDefault).id;
    isLoading.value = false;
  }

  void selectAddress(String id) {
    selectedAddressId.value = id;
  }

  void selectPayment(String id) {
    selectedPaymentId.value = id;
  }

  void setDeliveryOption(String option) {
    deliveryOption.value = option;
  }

  Future<void> placeOrder() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _cartController.clear();
    Get.offAllNamed(AppRoutes.orderSuccess);
  }
}
