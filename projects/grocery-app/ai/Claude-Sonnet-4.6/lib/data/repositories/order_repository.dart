import 'package:grocery_app/data/datasource/mock_data.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/cart_item_model.dart';
import 'package:grocery_app/data/models/order_model.dart';

/// Manages orders and address data.
class OrderRepository {
  const OrderRepository();

  // ─── Orders ───────────────────────────────────────────────────────────────

  Future<List<OrderModel>> getOrderHistory(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return MockData.orders
        .where((o) => o.userId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<OrderModel?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return MockData.orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }

  /// Simulates placing an order. Returns a newly created [OrderModel].
  Future<OrderModel> placeOrder({
    required String userId,
    required List<CartItemModel> cartItems,
    required AddressModel deliveryAddress,
    required double subtotal,
    required double discountAmount,
    required double deliveryFee,
    required double total,
    required String paymentMethod,
    required DeliveryOption deliveryOption,
    String? promoCode,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final orderId =
        'ORD-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}';

    final orderItems = cartItems
        .map((item) => OrderItem(
              productId: item.product.id,
              productName: item.product.name,
              productImage: item.product.images.isNotEmpty
                  ? item.product.images.first
                  : '',
              price: item.product.effectivePrice,
              quantity: item.quantity,
              variantLabel: item.selectedVariant?.label,
            ))
        .toList();

    final now = DateTime.now();
    final trackingEvents = [
      OrderTrackingEvent(
        title: 'Order Placed',
        description: 'Your order has been received and confirmed.',
        timestamp: now,
      ),
      OrderTrackingEvent(
        title: 'Processing',
        description: 'We are preparing your items.',
        timestamp: now.add(const Duration(hours: 1)),
        isCompleted: false,
      ),
      OrderTrackingEvent(
        title: 'Shipped',
        description: 'Your order is on its way.',
        timestamp: now.add(const Duration(hours: 6)),
        isCompleted: false,
      ),
      OrderTrackingEvent(
        title: 'Delivered',
        description: 'Package delivered to your door.',
        timestamp: now.add(const Duration(days: 2)),
        isCompleted: false,
      ),
    ];

    final order = OrderModel(
      id: orderId,
      userId: userId,
      items: orderItems,
      deliveryAddress: deliveryAddress,
      subtotal: subtotal,
      discountAmount: discountAmount,
      deliveryFee: deliveryFee,
      total: total,
      status: OrderStatus.confirmed,
      createdAt: now,
      estimatedDelivery: now.add(const Duration(days: 2)),
      promoCode: promoCode,
      paymentMethod: paymentMethod,
      deliveryOption: deliveryOption,
      trackingEvents: trackingEvents,
    );

    // In a real app, persist to backend. Mock: add to in-memory list.
    MockData.orders.insert(0, order);
    return order;
  }

  // ─── Addresses ────────────────────────────────────────────────────────────

  Future<List<AddressModel>> getAddresses(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List<AddressModel>.from(MockData.addresses);
  }

  Future<AddressModel> addAddress({
    required String userId,
    required AddressModel address,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    MockData.addresses.add(address);
    return address;
  }

  Future<void> deleteAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    MockData.addresses.removeWhere((a) => a.id == addressId);
  }

  Future<void> setDefaultAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    for (int i = 0; i < MockData.addresses.length; i++) {
      MockData.addresses[i] =
          MockData.addresses[i].copyWith(isDefault: MockData.addresses[i].id == addressId);
    }
  }
}
