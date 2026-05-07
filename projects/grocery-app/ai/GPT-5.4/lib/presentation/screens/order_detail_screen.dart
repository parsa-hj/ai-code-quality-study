import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_formatters.dart';
import '../../widgets/app_page_shell.dart';
import '../controllers/orders_controller.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/info_tile.dart';

class OrderDetailScreen extends GetView<OrdersController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments as String?;
    final order = orderId == null ? null : controller.findById(orderId);

    return AppPageShell(
      title: 'Order detail',
      child: order == null
          ? const EmptyStateView(
              icon: Icons.inbox_outlined,
              title: 'Order not found',
              message: 'The selected order could not be loaded.',
            )
          : ListView(
              children: [
                InfoTile(
                  icon: Icons.local_shipping_outlined,
                  title: 'Status',
                  subtitle: '${order.status} • ETA ${order.eta}',
                ),
                InfoTile(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery address',
                  subtitle: order.deliveryAddress,
                ),
                InfoTile(
                  icon: Icons.schedule_outlined,
                  title: 'Placed on',
                  subtitle: order.createdAt,
                ),
                const SizedBox(height: 14),
                Text('Items', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                ...order.items.map(
                  (item) => Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('${item.variant} • Qty ${item.quantity}'),
                      trailing: Text(AppFormatters.currency(item.total)),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        const Text('Order total'),
                        const Spacer(),
                        Text(
                          AppFormatters.currency(order.total),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
