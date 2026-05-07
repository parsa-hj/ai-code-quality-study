import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_formatters.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_page_shell.dart';
import '../controllers/cart_controller.dart';
import '../widgets/app_button.dart';
import '../widgets/app_network_image.dart';
import '../widgets/app_text_field.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/price_breakdown_card.dart';
import '../widgets/quantity_selector.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final promoController = TextEditingController();
    return AppPageShell(
      title: 'Your cart',
      child: Obx(() {
        if (controller.items.isEmpty) {
          return EmptyStateView(
            icon: Icons.shopping_bag_outlined,
            title: 'Your cart is empty',
            message: 'Add groceries to start building your next delivery.',
            actionLabel: 'Go shopping',
            onAction: () => Get.offNamed(AppRoutes.home),
          );
        }

        return ListView(
          children: [
            ...controller.items.map(
              (item) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      AppNetworkImage(
                        imageUrl: item.imageUrl,
                        height: 92,
                        width: 92,
                        borderRadius: 20,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text(item.variant),
                            const SizedBox(height: 8),
                            Text(
                              AppFormatters.currency(item.unitPrice),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => controller.removeItem(item),
                            icon: const Icon(Icons.delete_outline),
                          ),
                          QuantitySelector(
                            quantity: item.quantity,
                            onAdd: () => controller.updateQuantity(item, item.quantity + 1),
                            onRemove: () => controller.updateQuantity(item, item.quantity - 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'Promo code',
                    controller: promoController,
                    prefixIcon: Icons.local_offer_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                AppButton(
                  label: 'Apply',
                  expanded: false,
                  onPressed: () => controller.applyPromo(promoController.text),
                ),
              ],
            ),
            if (controller.appliedPromoCode.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text('Applied code: ${controller.appliedPromoCode.value}'),
            ],
            const SizedBox(height: 18),
            PriceBreakdownCard(
              subtotal: controller.subtotal,
              discount: controller.discount,
              deliveryFee: controller.deliveryFee,
              total: controller.total,
            ),
            const SizedBox(height: 18),
            AppButton(
              label: 'Proceed to checkout',
              onPressed: () => Get.toNamed(AppRoutes.checkout),
            ),
          ],
        );
      }),
    );
  }
}
