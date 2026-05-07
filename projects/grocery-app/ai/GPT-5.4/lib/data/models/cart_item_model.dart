class CartItemModel {
  const CartItemModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.variant,
    required this.unitPrice,
    required this.quantity,
  });

  final String productId;
  final String name;
  final String imageUrl;
  final String variant;
  final double unitPrice;
  final int quantity;

  double get total => unitPrice * quantity;

  CartItemModel copyWith({
    String? productId,
    String? name,
    String? imageUrl,
    String? variant,
    double? unitPrice,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      variant: variant ?? this.variant,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      variant: json['variant'] as String,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'variant': variant,
      'unitPrice': unitPrice,
      'quantity': quantity,
    };
  }
}
