import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/order_controller.dart';
import 'package:grocery_app/data/models/order_model.dart';

/// Order detail screen showing items and tracking timeline.
class OrderDetailScreen extends GetView<OrderController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load from arguments if not already set.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.selectedOrder.value == null) {
        controller.setOrderFromArgs();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.orderDetail)),
      body: Obx(
        () {
          final order = controller.selectedOrder.value;
          if (order == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order id + status
                Row(
                  children: [
                    Text(
                      '#${order.id.substring(order.id.length - 8).toUpperCase()}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    _StatusChip(status: order.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  Helpers.formatDateTime(order.createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),

                const SizedBox(height: AppSizes.spacingXL),

                // Items
                Text(
                  AppStrings.items,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.spacingMD),
                ...order.items.map((item) => _OrderItemRow(item: item)),

                const Divider(height: AppSizes.spacingXXL),

                // Pricing
                _PriceRow(AppStrings.subtotal, Helpers.formatPrice(order.subtotal)),
                if (order.discountAmount > 0)
                  _PriceRow(AppStrings.discount,
                      '-${Helpers.formatPrice(order.discountAmount)}',
                      color: AppColors.success),
                _PriceRow(
                    AppStrings.delivery, Helpers.formatPrice(order.deliveryFee)),
                const Divider(height: AppSizes.spacingLG),
                _PriceRow(AppStrings.total, Helpers.formatPrice(order.total),
                    isBold: true),

                const SizedBox(height: AppSizes.spacingXL),

                // Delivery address
                Text(
                  AppStrings.deliveryAddress,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingMD),
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? AppColors.darkSurface
                        : AppColors.grey100,
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  ),
                  child: Text(
                    order.deliveryAddress.fullAddress,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingXL),

                // Tracking timeline
                if (order.trackingEvents.isNotEmpty) ...[
                  Text(
                    AppStrings.trackingTimeline,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSizes.spacingMD),
                  _TrackingTimeline(events: order.trackingEvents),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final OrderStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case OrderStatus.delivered:
        color = AppColors.success;
        break;
      case OrderStatus.cancelled:
        color = AppColors.error;
        break;
      case OrderStatus.outForDelivery:
      case OrderStatus.shipped:
        color = AppColors.info;
        break;
      default:
        color = AppColors.warning;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
            color: color,
            fontSize: AppSizes.fontSM,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItem item;
  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.productName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            'x${item.quantity}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Text(
            Helpers.formatPrice(item.unitPrice * item.quantity),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? color;

  const _PriceRow(this.label, this.value,
      {this.isBold = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: isBold
                ? Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)
                : Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
          ),
          const Spacer(),
          Text(
            value,
            style: isBold
                ? Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    )
                : Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
          ),
        ],
      ),
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  final List<OrderTrackingEvent> events;
  const _TrackingTimeline({required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(events.length, (i) {
        final e = events[i];
        final isLast = i == events.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e.isCompleted ? AppColors.primary : AppColors.grey300,
                    ),
                    child: e.isCompleted
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: e.isCompleted
                            ? AppColors.primary
                            : AppColors.grey200,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: e.isCompleted
                                  ? null
                                  : AppColors.textSecondary,
                            ),
                      ),
                      Text(
                        e.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Helpers.formatDateTime(e.timestamp),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey400,
                              fontSize: 11,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
