import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Cart screen showing items, promo code, and order summary.
class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myCart),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Obx(
            () => controller.isNotEmpty
                ? TextButton(
                    onPressed: () => _confirmClear(context),
                    child: const Text(AppStrings.clearAll,
                        style: TextStyle(color: AppColors.error)),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(
        () => controller.isEmpty
            ? _EmptyCart()
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(AppSizes.paddingLG),
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSizes.spacingMD),
                      itemCount: controller.items.length,
                      itemBuilder: (_, i) =>
                          _CartItemTile(item: controller.items[i]),
                    ),
                  ),
                  _OrderSummary(cart: controller),
                ],
              ),
      ),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.clearCart),
        content: const Text(AppStrings.clearCartConfirm),
        actions: [
          TextButton(onPressed: Get.back, child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            child: const Text(AppStrings.clear,
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

// ─── Cart Item Tile ───────────────────────────────────────────────────────────

class _CartItemTile extends StatelessWidget {
  final CartItemModel item;
  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final isDark = context.isDark;

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cart.removeItem(item.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
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
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              child: CachedNetworkImage(
                imageUrl: item.product.imageUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(width: 72, height: 72, color: AppColors.grey100),
                errorWidget: (_, __, ___) =>
                    Container(width: 72, height: 72, color: AppColors.grey100),
              ),
            ),
            const SizedBox(width: 12),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.selectedVariant != null)
                    Text(
                      item.selectedVariant!.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  Text(
                    Helpers.formatPrice(item.product.effectivePrice +
                        (item.selectedVariant?.extraCost ?? 0)),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSM,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity controls + line total
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Helpers.formatPrice(item.lineTotal),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey200),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _QtyBtn(
                        icon: Icons.remove,
                        onTap: () => cart.updateQuantity(
                            item.id, item.quantity - 1),
                      ),
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${item.quantity}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      _QtyBtn(
                        icon: Icons.add,
                        onTap: () => cart.updateQuantity(
                            item.id, item.quantity + 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Icon(icon, size: 16),
      ),
    );
  }
}

// ─── Order Summary ────────────────────────────────────────────────────────────

class _OrderSummary extends StatelessWidget {
  final CartController cart;
  const _OrderSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXL)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            _SummaryRow(
              label: AppStrings.subtotal,
              value: Helpers.formatPrice(cart.subtotal),
            ),
            const SizedBox(height: 6),
            _SummaryRow(
              label: AppStrings.delivery,
              value: cart.subtotal >= AppConstants.freeDeliveryThreshold
                  ? AppStrings.free
                  : Helpers.formatPrice(AppConstants.standardDeliveryFee),
              valueColor:
                  cart.subtotal >= AppConstants.freeDeliveryThreshold
                      ? AppColors.success
                      : null,
            ),
            const Divider(height: AppSizes.spacingLG),
            _SummaryRow(
              label: AppStrings.total,
              value: Helpers.formatPrice(
                cart.subtotal +
                    (cart.subtotal >= AppConstants.freeDeliveryThreshold
                        ? 0
                        : AppConstants.standardDeliveryFee),
              ),
              isBold: true,
            ),
            const SizedBox(height: AppSizes.spacingLG),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.checkout),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.proceedToCheckout),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: isBold
              ? Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)
              : Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
        ),
        const Spacer(),
        Text(
          value,
          style: isBold
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
        ),
      ],
    );
  }
}

// ─── Empty Cart ───────────────────────────────────────────────────────────────

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined,
              size: 80, color: AppColors.grey300),
          const SizedBox(height: AppSizes.spacingLG),
          Text(AppStrings.emptyCart,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSizes.spacingSM),
          Text(AppStrings.emptyCartSubtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSizes.spacingXXL),
          OutlinedButton(
            onPressed: Get.back,
            child: const Text(AppStrings.continueShopping),
          ),
        ],
      ),
    );
  }
}
