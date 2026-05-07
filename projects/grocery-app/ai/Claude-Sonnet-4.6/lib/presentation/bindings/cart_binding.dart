import 'package:get/get.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/presentation/controllers/checkout_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // CartController is already registered as permanent in InitialBinding.
    // Register CheckoutController lazily when cart/checkout is visited.
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(Get.find(), Get.find(), Get.find()),
    );
  }
}
