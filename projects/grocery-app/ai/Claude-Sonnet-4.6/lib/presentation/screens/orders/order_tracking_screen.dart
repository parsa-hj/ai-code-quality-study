import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/order_controller.dart';
import 'package:grocery_app/data/models/order_model.dart';

/// Live order tracking screen.
class OrderTrackingScreen extends GetView<OrderController> {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.selectedOrder.value == null) {
        controller.setOrderFromArgs();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.orderTracking)),
      body: Obx(
        () {
          final order = controller.selectedOrder.value;
          if (order == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Calculate active step
          final events = order.trackingEvents;
          final completedCount = events.where((e) => e.isCompleted).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingLG),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                  ),
                  child: Column(
                    children: [
                      Text(
                        order.status.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.fontXL,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${completedCount} of ${events.length} steps completed',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: events.isEmpty
                            ? 0
                            : completedCount / events.length,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor:
                            const AlwaysStoppedAnimation(Colors.white),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.spacingXL),

                Text(
                  AppStrings.trackingTimeline,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.spacingMD),

                // Timeline
                Column(
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
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: e.isCompleted
                                      ? AppColors.primary
                                      : AppColors.grey200,
                                  border: Border.all(
                                    color: e.isCompleted
                                        ? AppColors.primary
                                        : AppColors.grey300,
                                    width: 2,
                                  ),
                                ),
                                child: e.isCompleted
                                    ? const Icon(Icons.check,
                                        size: 14, color: Colors.white)
                                    : null,
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: e.isCompleted
                                        ? AppColors.primary
                                        : AppColors.grey200,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: isLast ? 0 : 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: e.isCompleted
                                              ? null
                                              : AppColors.textSecondary,
                                        ),
                                  ),
                                  Text(
                                    e.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.textSecondary),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    Helpers.formatDateTime(e.timestamp),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
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
                ),

                const SizedBox(height: AppSizes.spacingXXL),

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
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          order.deliveryAddress.fullAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
