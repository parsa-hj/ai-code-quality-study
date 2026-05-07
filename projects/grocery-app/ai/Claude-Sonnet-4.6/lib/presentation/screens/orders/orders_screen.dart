import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/order_controller.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Orders list screen.
class OrdersScreen extends GetView<OrderController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myOrders),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.orders.isEmpty
                ? _EmptyOrders()
                : RefreshIndicator(
                    onRefresh: controller.loadOrders,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(AppSizes.paddingLG),
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSizes.spacingMD),
                      itemCount: controller.orders.length,
                      itemBuilder: (_, i) =>
                          _OrderTile(order: controller.orders[i]),
                    ),
                  ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final OrderModel order;
  const _OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final statusColor = _statusColor(order.status);

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.orderDetail,
        arguments: {'order': order},
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '#${order.id.substring(order.id.length - 8).toUpperCase()}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status.label,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: AppSizes.fontSM,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              Helpers.formatDate(order.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${order.items.length} ${Helpers.itemCount(order.items.length)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(height: 16),
            Row(
              children: [
                Text(
                  AppStrings.total,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Text(
                  Helpers.formatPrice(order.total),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
      case OrderStatus.outForDelivery:
      case OrderStatus.shipped:
        return AppColors.info;
      default:
        return AppColors.warning;
    }
  }
}

class _EmptyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt_long_outlined,
              size: 80, color: AppColors.grey300),
          const SizedBox(height: AppSizes.spacingLG),
          Text(AppStrings.noOrders,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSizes.spacingMD),
          OutlinedButton(
            onPressed: () => Get.offAllNamed(AppRoutes.main),
            child: const Text(AppStrings.startShopping),
          ),
        ],
      ),
    );
  }
}
