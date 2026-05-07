import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/core/services/auth_service.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/repositories/order_repository.dart';

/// Manages order history, detail, and tracking state.
class OrderController extends GetxController {
  final OrderRepository _orderRepository;
  final AuthService _authService;

  OrderController(this._orderRepository, this._authService);

  // ─── State ────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final Rx<OrderModel?> selectedOrder = Rx<OrderModel?>(null);
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    // Check if an order was passed as argument (from order detail page).
    final args = Get.arguments;
    if (args is Map && args['order'] is OrderModel) {
      selectedOrder.value = args['order'] as OrderModel;
    }
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  Future<void> loadOrders() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final userId = _authService.currentUser.value?.id ?? '';
      orders.value = await _orderRepository.getOrderHistory(userId);
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = AppStrings.somethingWrong;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectOrder(String orderId) async {
    try {
      selectedOrder.value = await _orderRepository.getOrderById(orderId);
    } catch (_) {
      selectedOrder.value =
          orders.firstWhereOrNull((o) => o.id == orderId);
    }
  }

  void setOrderFromArgs() {
    final args = Get.arguments;
    if (args is Map && args['order'] is OrderModel) {
      selectedOrder.value = args['order'] as OrderModel;
    } else if (args is String) {
      selectOrder(args);
    }
  }
}
