import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_page_shell.dart';
import '../../routes/app_routes.dart';
import '../controllers/orders_controller.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/info_tile.dart';
import '../widgets/skeleton_box.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageShell(
      title: 'Orders',
      child: Obx(() {
        if (controller.isLoading.value) {
          return ListView(
            children: const [
              SkeletonBox(height: 110),
              SizedBox(height: 12),
              SkeletonBox(height: 110),
            ],
          );
        }
        if (controller.orders.isEmpty) {
          return const EmptyStateView(
            icon: Icons.receipt_long_outlined,
            title: 'No orders yet',
            message: 'Once you place an order, your history will show up here.',
          );
        }

        return ListView.separated(
          itemCount: controller.orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return InfoTile(
              icon: Icons.delivery_dining_outlined,
              title: 'Order #${order.id}',
              subtitle: '${order.status} • ${order.createdAt} • ${order.items.length} items',
              trailing: FilledButton.tonal(
                onPressed: () => Get.toNamed(AppRoutes.orderDetail, arguments: order.id),
                child: const Text('View'),
              ),
              onTap: () => Get.toNamed(AppRoutes.tracking, arguments: order.id),
            );
          },
        );
      }),
    );
  }
}
