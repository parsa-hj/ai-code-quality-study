import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_page_shell.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/app_button.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/info_tile.dart';
import '../widgets/price_breakdown_card.dart';
import '../widgets/skeleton_box.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return AppPageShell(
      title: 'Checkout',
      child: Obx(() {
        if (cartController.items.isEmpty) {
          return const EmptyStateView(
            icon: Icons.shopping_cart_checkout_outlined,
            title: 'No items to checkout',
            message: 'Add some groceries before opening checkout.',
          );
        }
        if (controller.isLoading.value) {
          return ListView(
            children: const [
              SkeletonBox(height: 120),
              SizedBox(height: 12),
              SkeletonBox(height: 160),
              SizedBox(height: 12),
              SkeletonBox(height: 220),
            ],
          );
        }

        return ListView(
          children: [
            Text('Delivery address', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...controller.addresses.map(
              (address) => Card(
                child: RadioListTile<String>(
                  value: address.id,
                  groupValue: controller.selectedAddressId.value,
                  onChanged: (value) => controller.selectAddress(value!),
                  title: Text(address.label),
                  subtitle: Text('${address.addressLine}\n${address.city}'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Delivery options', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: ['Priority', 'Standard', 'Scheduled']
                  .map(
                    (option) => Obx(
                      () => ChoiceChip(
                        label: Text(option),
                        selected: controller.deliveryOption.value == option,
                        onSelected: (_) => controller.setDeliveryOption(option),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text('Payment method', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...controller.paymentMethods.map(
              (payment) => Card(
                child: RadioListTile<String>(
                  value: payment.id,
                  groupValue: controller.selectedPaymentId.value,
                  onChanged: (value) => controller.selectPayment(value!),
                  title: Text(payment.title),
                  subtitle: Text(payment.subtitle),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Order summary', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...cartController.items.map(
              (item) => InfoTile(
                icon: Icons.shopping_bag_outlined,
                title: item.name,
                subtitle: '${item.variant} • Qty ${item.quantity}',
                trailing: Text('\$${item.total.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 18),
            PriceBreakdownCard(
              subtotal: cartController.subtotal,
              discount: cartController.discount,
              deliveryFee: cartController.deliveryFee,
              total: cartController.total,
            ),
            const SizedBox(height: 18),
            AppButton(label: 'Place order', onPressed: controller.placeOrder),
          ],
        );
      }),
    );
  }
}
