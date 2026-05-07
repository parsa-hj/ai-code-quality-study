import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Shown after a successful order placement.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map?;
    final order = args?['order'] as OrderModel?;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingXXL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success animation placeholder
                Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    color: AppColors.successLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: 80,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXXXL),
                Text(
                  AppStrings.orderPlaced,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacingMD),
                if (order != null) ...[
                  Text(
                    '${AppStrings.orderNumber} #${order.id.substring(order.id.length - 8).toUpperCase()}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spacingSM),
                ],
                Text(
                  AppStrings.orderPlacedSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacingXXXL),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.orders),
                  child: const Text(AppStrings.trackOrder),
                ),
                const SizedBox(height: AppSizes.spacingMD),
                OutlinedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.main),
                  child: const Text(AppStrings.continueShopping),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
