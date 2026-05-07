import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/checkout_controller.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/data/models/order_model.dart';

/// Checkout screen: address, delivery, payment, promo, place order.
class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final promoCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.checkout),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(AppSizes.paddingLG),
                children: [
                  // ── Delivery Address ──────────────────────────────────
                  _SectionCard(
                    title: AppStrings.deliveryAddress,
                    icon: Icons.location_on_outlined,
                    child: Obx(
                      () => controller.addresses.isEmpty
                          ? TextButton.icon(
                              onPressed: () =>
                                  Get.toNamed(AppRoutes.addresses),
                              icon: const Icon(Icons.add),
                              label: const Text(AppStrings.addAddress),
                            )
                          : Column(
                              children: controller.addresses.map((addr) {
                                final isSelected =
                                    controller.selectedAddress.value?.id ==
                                        addr.id;
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Radio<String>(
                                    value: addr.id,
                                    groupValue:
                                        controller.selectedAddress.value?.id,
                                    onChanged: (_) =>
                                        controller.selectAddress(addr),
                                    activeColor: AppColors.primary,
                                  ),
                                  title: Text(
                                    addr.shortAddress,
                                    style: isSelected
                                        ? const TextStyle(
                                            fontWeight: FontWeight.w600)
                                        : null,
                                  ),
                                  subtitle: Text(addr.fullAddress,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                            ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spacingLG),

                  // ── Delivery Option ───────────────────────────────────
                  _SectionCard(
                    title: AppStrings.deliveryOption,
                    icon: Icons.local_shipping_outlined,
                    child: Obx(
                      () => Column(
                        children: DeliveryOption.values.map((opt) {
                          String _optLabel(DeliveryOption o) {
                            switch (o) {
                              case DeliveryOption.express:
                                return 'Express (1-2 days)';
                              case DeliveryOption.scheduled:
                                return 'Scheduled';
                              default:
                                return 'Standard (3-5 days)';
                            }
                          }

                          double _optFee(DeliveryOption o) {
                            switch (o) {
                              case DeliveryOption.express:
                                return AppConstants.expressDeliveryFee;
                              case DeliveryOption.scheduled:
                                return AppConstants.scheduledDeliveryFee;
                              default:
                                return AppConstants.standardDeliveryFee;
                            }
                          }

                          final label = _optLabel(opt);
                          final fee = _optFee(opt);
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Radio<DeliveryOption>(
                              value: opt,
                              groupValue: controller.selectedDelivery.value,
                              onChanged: controller.selectDelivery,
                              activeColor: AppColors.primary,
                            ),
                            title: Text(label),
                            trailing: Text(
                              cart.subtotal >= AppConstants.freeDeliveryThreshold &&
                                      opt == DeliveryOption.standard
                                  ? AppStrings.free
                                  : Helpers.formatPrice(fee),
                              style: TextStyle(
                                color: cart.subtotal >=
                                            AppConstants.freeDeliveryThreshold &&
                                        opt == DeliveryOption.standard
                                    ? AppColors.success
                                    : null,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spacingLG),

                  // ── Payment Method ────────────────────────────────────
                  _SectionCard(
                    title: AppStrings.paymentMethod,
                    icon: Icons.payment_outlined,
                    child: Obx(
                      () => Column(
                        children: controller.savedPaymentMethods.map((m) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Radio<String>(
                              value: m,
                              groupValue: controller.selectedPaymentMethod.value,
                              onChanged: controller.selectPayment,
                              activeColor: AppColors.primary,
                            ),
                            title: Text(m),
                            trailing: Icon(
                              m.startsWith('Visa')
                                  ? Icons.credit_card
                                  : m.startsWith('Master')
                                      ? Icons.credit_card
                                      : Icons.money_outlined,
                              color: AppColors.primary,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spacingLG),

                  // ── Promo Code ────────────────────────────────────────
                  _SectionCard(
                    title: AppStrings.promoCode,
                    icon: Icons.local_offer_outlined,
                    child: Obx(() {
                      if (controller.appliedPromo.value != null) {
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusSM),
                                border: Border.all(color: AppColors.success),
                              ),
                              child: Text(
                                controller.appliedPromo.value!.code,
                                style: const TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                controller.appliedPromo.value!.description,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close,
                                  color: AppColors.error),
                              onPressed: controller.removePromo,
                            ),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: promoCtrl,
                                  decoration: const InputDecoration(
                                    hintText: AppStrings.enterPromoCode,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    isDense: true,
                                  ),
                                  textCapitalization:
                                      TextCapitalization.characters,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: controller.promoLoading.value
                                    ? null
                                    : () => controller.applyPromoCode(
                                        promoCtrl.text, cart.subtotal),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: controller.promoLoading.value
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white),
                                      )
                                    : const Text(AppStrings.apply),
                              ),
                            ],
                          ),
                          if (controller.promoError.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                controller.promoError.value,
                                style: const TextStyle(
                                    color: AppColors.error,
                                    fontSize: AppSizes.fontSM),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),

                  const SizedBox(height: AppSizes.spacingLG),

                  // ── Order Summary ─────────────────────────────────────
                  _SectionCard(
                    title: AppStrings.orderSummary,
                    icon: Icons.receipt_outlined,
                    child: Obx(
                      () => Column(
                        children: [
                          _Row(AppStrings.subtotal,
                              Helpers.formatPrice(cart.subtotal)),
                          if (controller.appliedPromo.value != null)
                            _Row(
                              AppStrings.discount,
                              '-${Helpers.formatPrice(controller.discountAmount(cart.subtotal))}',
                              color: AppColors.success,
                            ),
                          _Row(
                            AppStrings.delivery,
                            controller.deliveryFee(cart.subtotal) == 0
                                ? AppStrings.free
                                : Helpers.formatPrice(
                                    controller.deliveryFee(cart.subtotal)),
                            color:
                                controller.deliveryFee(cart.subtotal) == 0
                                    ? AppColors.success
                                    : null,
                          ),
                          const Divider(height: 20),
                          _Row(
                            AppStrings.total,
                            Helpers.formatPrice(
                                controller.orderTotal(cart.subtotal)),
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spacingXXL),

                  // ── Place Order ────────────────────────────────────────
                  Obx(
                    () => ElevatedButton(
                      onPressed: controller.isPlacingOrder.value
                          ? null
                          : () => controller.placeOrder(cart),
                      child: controller.isPlacingOrder.value
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.5, color: Colors.white),
                            )
                          : Text(
                              '${AppStrings.placeOrder} • ${Helpers.formatPrice(controller.orderTotal(cart.subtotal))}',
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingXXL),
                ],
              ),
      ),
    );
  }
}

// Helpers
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard(
      {required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : Colors.white,
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
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? color;

  const _Row(this.label, this.value, {this.isBold = false, this.color});

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
                : Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}
