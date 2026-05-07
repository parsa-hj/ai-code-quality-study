import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_page_shell.dart';
import '../controllers/orders_controller.dart';
import '../widgets/empty_state_view.dart';

class TrackingScreen extends GetView<OrdersController> {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments as String?;
    final order = orderId == null
        ? (controller.orders.isNotEmpty ? controller.orders.first : null)
        : controller.findById(orderId);

    if (order == null) {
      return const Scaffold(
        body: EmptyStateView(
          icon: Icons.map_outlined,
          title: 'Tracking unavailable',
          message: 'Place an order to see live delivery progress.',
        ),
      );
    }

    const steps = [
      _TrackingStep(label: 'Order confirmed', isDone: true),
      _TrackingStep(label: 'Packed by store', isDone: true),
      _TrackingStep(label: 'Courier assigned', isDone: true),
      _TrackingStep(label: 'On the way', isDone: true),
      _TrackingStep(label: 'Delivered', isDone: false),
    ];

    return AppPageShell(
      title: 'Track order',
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order #${order.id}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('ETA ${order.eta} • ${order.status}'),
                  const SizedBox(height: 8),
                  Text(order.deliveryAddress),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: step.isDone
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).dividerColor,
                      child: Icon(
                        step.isDone ? Icons.check : Icons.circle,
                        size: 14,
                        color: step.isDone
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    if (index != steps.length - 1)
                      Container(
                        width: 2,
                        height: 48,
                        color: step.isDone
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).dividerColor,
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(step.label),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _TrackingStep {
  const _TrackingStep({required this.label, required this.isDone});

  final String label;
  final bool isDone;
}
