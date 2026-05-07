import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/product_model.dart';

/// Possible states an order can be in.
enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive =>
      this == OrderStatus.pending ||
      this == OrderStatus.confirmed ||
      this == OrderStatus.processing ||
      this == OrderStatus.shipped ||
      this == OrderStatus.outForDelivery;
}

/// An item within an order (snapshot of product at purchase time).
class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String? variantLabel;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.variantLabel,
  });

  double get lineTotal => price * quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      variantLabel: json['variantLabel'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'productImage': productImage,
        'price': price,
        'quantity': quantity,
        'variantLabel': variantLabel,
      };

  /// Creates an OrderItem snapshot from a ProductModel.
  factory OrderItem.fromProduct(ProductModel product,
      {required int quantity, String? variantLabel}) {
    return OrderItem(
      productId: product.id,
      productName: product.name,
      productImage:
          product.images.isNotEmpty ? product.images.first : '',
      price: product.effectivePrice,
      quantity: quantity,
      variantLabel: variantLabel,
    );
  }
}

/// A tracking event in the order timeline.
class OrderTrackingEvent {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isCompleted;

  const OrderTrackingEvent({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isCompleted = true,
  });

  factory OrderTrackingEvent.fromJson(Map<String, dynamic> json) {
    return OrderTrackingEvent(
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isCompleted: (json['isCompleted'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'timestamp': timestamp.toIso8601String(),
        'isCompleted': isCompleted,
      };
}

/// The delivery option selected at checkout.
enum DeliveryOption { standard, express, scheduled }

/// Full order model.
class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final AddressModel deliveryAddress;
  final double subtotal;
  final double discountAmount;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;
  final String? promoCode;
  final String paymentMethod;
  final DeliveryOption deliveryOption;
  final List<OrderTrackingEvent> trackingEvents;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.deliveryAddress,
    required this.subtotal,
    this.discountAmount = 0.0,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDelivery,
    this.promoCode,
    required this.paymentMethod,
    required this.deliveryOption,
    this.trackingEvents = const [],
  });

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryAddress: AddressModel.fromJson(
          json['deliveryAddress'] as Map<String, dynamic>),
      subtotal: (json['subtotal'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      estimatedDelivery: json['estimatedDelivery'] != null
          ? DateTime.tryParse(json['estimatedDelivery'] as String)
          : null,
      promoCode: json['promoCode'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      deliveryOption: DeliveryOption.values.firstWhere(
        (d) => d.name == json['deliveryOption'],
        orElse: () => DeliveryOption.standard,
      ),
      trackingEvents: (json['trackingEvents'] as List<dynamic>?)
              ?.map((e) =>
                  OrderTrackingEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'items': items.map((i) => i.toJson()).toList(),
        'deliveryAddress': deliveryAddress.toJson(),
        'subtotal': subtotal,
        'discountAmount': discountAmount,
        'deliveryFee': deliveryFee,
        'total': total,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'estimatedDelivery': estimatedDelivery?.toIso8601String(),
        'promoCode': promoCode,
        'paymentMethod': paymentMethod,
        'deliveryOption': deliveryOption.name,
        'trackingEvents': trackingEvents.map((e) => e.toJson()).toList(),
      };
}
