import 'dart:convert';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/core/services/storage_service.dart';
import 'package:grocery_app/data/models/product_model.dart';

/// Manages the user's wishlist (permanent controller).
class WishlistController extends GetxController {
  final StorageService _storage;

  WishlistController(this._storage);

  // ─── State ────────────────────────────────────────────────────────────────
  final RxList<ProductModel> items = <ProductModel>[].obs;

  bool get isEmpty => items.isEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  void toggle(ProductModel product) {
    if (isInWishlist(product.id)) {
      remove(product.id);
    } else {
      add(product);
    }
  }

  void add(ProductModel product) {
    if (!isInWishlist(product.id)) {
      items.add(product);
      _saveToStorage();
      Get.snackbar(
        'Wishlist',
        AppStrings.addedToWishlist,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.secondary,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void remove(String productId) {
    items.removeWhere((p) => p.id == productId);
    _saveToStorage();
    Get.snackbar(
      'Wishlist',
      AppStrings.removedFromWishlist,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.grey500,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  bool isInWishlist(String productId) =>
      items.any((p) => p.id == productId);

  // ─── Persistence ──────────────────────────────────────────────────────────

  void _saveToStorage() {
    final data = items.map((p) => p.toJson()).toList();
    _storage.setString(AppConstants.keyWishlistData, jsonEncode(data));
  }

  void _loadFromStorage() {
    final raw = _storage.getString(AppConstants.keyWishlistData);
    if (raw == null) return;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      items.value = list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      items.clear();
    }
  }
}
