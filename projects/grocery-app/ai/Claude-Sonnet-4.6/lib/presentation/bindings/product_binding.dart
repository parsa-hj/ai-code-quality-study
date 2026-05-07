import 'package:get/get.dart';
import 'package:grocery_app/presentation/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(Get.find(), Get.find()),
    );
  }
}
