import 'dart:convert';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/core/services/storage_service.dart';
import 'package:grocery_app/data/models/cart_item_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';
import 'package:uuid/uuid.dart';

/// Manages the shopping cart state globally (permanent controller).
class CartController extends GetxController {
  final ProductRepository _productRepository;
  final StorageService _storage;

  CartController(this._productRepository, this._storage);

  static const _uuid = Uuid();

  // ─── State ────────────────────────────────────────────────────────────────
  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxBool isLoading = false.obs;

  // ─── Computed ─────────────────────────────────────────────────────────────

  int get itemCount => items.length;

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.lineTotal);

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  /// Adds a product to the cart. If already present, increases quantity.
  void addItem(
    ProductModel product, {
    int quantity = 1,
    ProductVariant? variant,
  }) {
    // Check if the exact same product+variant already exists
    final existingIndex = items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedVariant?.id == variant?.id,
    );

    if (existingIndex >= 0) {
      final existing = items[existingIndex];
      final newQty =
          (existing.quantity + quantity).clamp(1, AppConstants.maxItemQuantity);
      items[existingIndex] = existing.copyWith(quantity: newQty);
    } else {
      items.add(CartItemModel(
        id: _uuid.v4(),
        product: product,
        quantity: quantity.clamp(1, AppConstants.maxItemQuantity),
        selectedVariant: variant,
      ));
    }

    _saveToStorage();
    Get.snackbar(
      'Added to cart',
      '${product.name} added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Updates the quantity of an existing item.
  void updateQuantity(String itemId, int newQuantity) {
    final index = items.indexWhere((item) => item.id == itemId);
    if (index < 0) return;

    if (newQuantity <= 0) {
      removeItem(itemId);
    } else {
      items[index] = items[index].copyWith(
        quantity: newQuantity.clamp(1, AppConstants.maxItemQuantity),
      );
      _saveToStorage();
    }
  }

  /// Removes an item from the cart.
  void removeItem(String itemId) {
    items.removeWhere((item) => item.id == itemId);
    _saveToStorage();
    Get.snackbar(
      'Removed',
      'Item removed from your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Clears the entire cart (called after order placement).
  void clearCart() {
    items.clear();
    _saveToStorage();
  }

  bool containsProduct(String productId) =>
      items.any((item) => item.product.id == productId);

  int quantityOfProduct(String productId) {
    try {
      return items
          .firstWhere((item) => item.product.id == productId)
          .quantity;
    } catch (_) {
      return 0;
    }
  }

  // ─── Persistence ──────────────────────────────────────────────────────────

  void _saveToStorage() {
    final data = items.map((item) => item.toJson()).toList();
    _storage.setString(AppConstants.keyCartData, jsonEncode(data));
  }

  void _loadFromStorage() {
    final raw = _storage.getString(AppConstants.keyCartData);
    if (raw == null) return;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      items.value = list
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      // Corrupt data — start fresh
      items.clear();
    }
  }
}
