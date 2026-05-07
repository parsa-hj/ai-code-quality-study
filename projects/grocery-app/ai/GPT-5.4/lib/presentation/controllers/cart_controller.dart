import 'dart:convert';

import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/local_storage_service.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';

class CartController extends GetxController {
  CartController(this._storageService);

  final LocalStorageService _storageService;

  final items = <CartItemModel>[].obs;
  final appliedPromoCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _restoreCart();
  }

  void addToCart({
    required ProductModel product,
    required String variant,
    required int quantity,
  }) {
    final index = items.indexWhere(
      (item) => item.productId == product.id && item.variant == variant,
    );

    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
    } else {
      items.add(
        CartItemModel(
          productId: product.id,
          name: product.name,
          imageUrl: product.imageUrl,
          variant: variant,
          unitPrice: product.price,
          quantity: quantity,
        ),
      );
    }

    _persistCart();
    Get.snackbar('Added to cart', '${product.name} has been added to your cart.');
  }

  void updateQuantity(CartItemModel item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
      return;
    }

    final index = items.indexWhere(
      (current) =>
          current.productId == item.productId && current.variant == item.variant,
    );
    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: quantity);
      _persistCart();
    }
  }

  void removeItem(CartItemModel item) {
    items.removeWhere(
      (current) =>
          current.productId == item.productId && current.variant == item.variant,
    );
    _persistCart();
  }

  void applyPromo(String code) {
    appliedPromoCode.value = code.trim().toUpperCase();
  }

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.total);

  double get deliveryFee => items.isEmpty ? 0 : 4.99;

  double get discount => appliedPromoCode.value == 'FRESH20' ? subtotal * 0.2 : 0;

  double get total => subtotal + deliveryFee - discount;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  void clear() {
    items.clear();
    appliedPromoCode.value = '';
    _persistCart();
  }

  void _restoreCart() {
    final raw = _storageService.readString(StorageKeys.cartItems);
    if (raw == null || raw.isEmpty) {
      return;
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    items.assignAll(
      decoded
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<void> _persistCart() {
    return _storageService.writeString(
      StorageKeys.cartItems,
      jsonEncode(items.map((item) => item.toJson()).toList()),
    );
  }
}
