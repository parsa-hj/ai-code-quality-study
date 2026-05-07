import 'package:grocery_app/data/models/product_model.dart';

/// Represents a product in the cart with quantity and optional variant.
class CartItemModel {
  final String id; // unique cart entry id
  final ProductModel product;
  final int quantity;
  final ProductVariant? selectedVariant;

  const CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    this.selectedVariant,
  });

  /// Total price for this line item.
  double get lineTotal => product.effectivePrice * quantity;

  CartItemModel copyWith({
    String? id,
    ProductModel? product,
    int? quantity,
    ProductVariant? selectedVariant,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedVariant: selectedVariant ?? this.selectedVariant,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      selectedVariant: json['selectedVariant'] != null
          ? ProductVariant.fromJson(
              json['selectedVariant'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'product': product.toJson(),
        'quantity': quantity,
        'selectedVariant': selectedVariant?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CartItemModel && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
