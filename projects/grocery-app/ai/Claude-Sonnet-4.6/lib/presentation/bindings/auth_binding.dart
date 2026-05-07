import 'package:get/get.dart';
import 'package:grocery_app/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find()),
    );
  }
}
