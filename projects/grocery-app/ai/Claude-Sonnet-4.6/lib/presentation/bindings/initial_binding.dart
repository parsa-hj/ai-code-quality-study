import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/network/network_info.dart';
import 'package:grocery_app/core/services/auth_service.dart';
import 'package:grocery_app/core/services/storage_service.dart';
import 'package:grocery_app/data/repositories/auth_repository.dart';
import 'package:grocery_app/data/repositories/order_repository.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/presentation/controllers/wishlist_controller.dart';

/// Registers all global (permanent) dependencies on app startup.
class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // ─── Core Services (singletons) ───────────────────────────────────────
    final storageService = await Get.putAsync<StorageService>(
      () async => StorageService().init(),
      permanent: true,
    );

    final authService = await Get.putAsync<AuthService>(
      () async => AuthService(storageService).init(),
      permanent: true,
    );

    Get.put<NetworkInfo>(
      NetworkInfo(Connectivity()),
      permanent: true,
    );

    // ─── Repositories (singletons) ────────────────────────────────────────
    Get.put<AuthRepository>(
      AuthRepository(authService),
      permanent: true,
    );

    Get.put<ProductRepository>(
      const ProductRepository(),
      permanent: true,
    );

    Get.put<OrderRepository>(
      const OrderRepository(),
      permanent: true,
    );

    // ─── Global Controllers (persist across all routes) ────────────────────
    Get.put<CartController>(
      CartController(Get.find(), storageService),
      permanent: true,
    );

    Get.put<WishlistController>(
      WishlistController(storageService),
      permanent: true,
    );
  }
}
