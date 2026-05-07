import 'package:get/get.dart';
import 'package:grocery_app/presentation/controllers/home_controller.dart';
import 'package:grocery_app/presentation/controllers/profile_controller.dart';
import 'package:grocery_app/presentation/controllers/search_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find()),
    );
    Get.lazyPut<GrocerySearchController>(
      () => GrocerySearchController(Get.find()),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find(), Get.find()),
    );
  }
}
