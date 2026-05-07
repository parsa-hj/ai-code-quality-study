import 'package:get/get.dart';
import 'package:grocery_app/presentation/controllers/checkout_controller.dart';
import 'package:grocery_app/presentation/controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(Get.find(), Get.find(), Get.find()),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(Get.find(), Get.find()),
    );
  }
}
