import 'cart_item_model.dart';

class OrderModel {
  const OrderModel({
    required this.id,
    required this.items,
    required this.status,
    required this.total,
    required this.eta,
    required this.deliveryAddress,
    required this.createdAt,
  });

  final String id;
  final List<CartItemModel> items;
  final String status;
  final double total;
  final String eta;
  final String deliveryAddress;
  final String createdAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      total: (json['total'] as num).toDouble(),
      eta: json['eta'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
}
