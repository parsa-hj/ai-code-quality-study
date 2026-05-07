import 'package:get/get.dart';

import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';

class OrdersController extends GetxController {
  OrdersController(this._orderRepository);

  final OrderRepository _orderRepository;

  final isLoading = true.obs;
  final orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    orders.assignAll(await _orderRepository.getOrders());
    isLoading.value = false;
  }

  OrderModel? findById(String id) {
    try {
      return orders.firstWhere((order) => order.id == id);
    } catch (_) {
      return null;
    }
  }
}
