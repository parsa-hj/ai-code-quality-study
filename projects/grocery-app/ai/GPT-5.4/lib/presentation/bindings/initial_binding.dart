import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/network_info_service.dart';
import '../../core/services/local_storage_service.dart';
import '../../data/api_client/mock_api_client.dart';
import '../../data/datasource/mock_grocery_datasource.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/orders_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/theme_controller.dart';

class InitialBinding extends Bindings {
  static Future<void> setupDependencies() async {
    final preferences = await SharedPreferences.getInstance();

    if (!Get.isRegistered<LocalStorageService>()) {
      Get.put<LocalStorageService>(
        LocalStorageService(preferences),
        permanent: true,
      );
    }
    if (!Get.isRegistered<NetworkInfoService>()) {
      Get.put<NetworkInfoService>(
        NetworkInfoService(Connectivity()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<MockApiClient>()) {
      Get.put<MockApiClient>(MockApiClient(), permanent: true);
    }
    if (!Get.isRegistered<MockGroceryDataSource>()) {
      Get.put<MockGroceryDataSource>(
        MockGroceryDataSource(Get.find<MockApiClient>()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.put<AuthRepository>(AuthRepository(), permanent: true);
    }
    if (!Get.isRegistered<CatalogRepository>()) {
      Get.put<CatalogRepository>(
        CatalogRepository(Get.find<MockGroceryDataSource>()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<OrderRepository>()) {
      Get.put<OrderRepository>(
        OrderRepository(Get.find<MockGroceryDataSource>()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<ProfileRepository>()) {
      Get.put<ProfileRepository>(
        ProfileRepository(Get.find<MockGroceryDataSource>()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<ThemeController>()) {
      Get.put<ThemeController>(
        ThemeController(Get.find<LocalStorageService>()),
        permanent: true,
      );
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(Get.find<AuthRepository>()));
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<CatalogRepository>(),
        Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<CartController>(
      () => CartController(Get.find<LocalStorageService>()),
      fenix: true,
    );
    Get.lazyPut<ProductController>(ProductController.new, fenix: true);
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(
        Get.find<OrderRepository>(),
        Get.find<CartController>(),
      ),
      fenix: true,
    );
    Get.lazyPut<OrdersController>(
      () => OrdersController(Get.find<OrderRepository>()),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        Get.find<ProfileRepository>(),
        Get.find<OrderRepository>(),
        Get.find<ThemeController>(),
      ),
      fenix: true,
    );
  }
}
