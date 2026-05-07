import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/wishlist_controller.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Wishlist screen.
class WishlistScreen extends GetView<WishlistController> {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wishlist),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isEmpty
            ? _Empty()
            : GridView.builder(
                padding: const EdgeInsets.all(AppSizes.paddingLG),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSizes.spacingMD,
                  crossAxisSpacing: AppSizes.spacingMD,
                  childAspectRatio: 0.72,
                ),
                itemCount: controller.items.length,
                itemBuilder: (_, i) =>
                    _WishlistCard(product: controller.items[i]),
              ),
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final ProductModel product;
  const _WishlistCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistController>();
    final cart = Get.find<CartController>();

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetail,
          arguments: {'product': product}),
      child: Container(
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusLG)),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(height: 130, color: AppColors.grey100),
                    errorWidget: (_, __, ___) =>
                        Container(height: 130, color: AppColors.grey100),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => wishlist.remove(product.id),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.favorite,
                          color: AppColors.error, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        Helpers.formatPrice(product.effectivePrice),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizes.fontSM,
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () => GestureDetector(
                          onTap: () => cart.addItem(product),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: cart.containsProduct(product.id)
                                  ? AppColors.primaryDark
                                  : AppColors.primary,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusSM),
                            ),
                            child: Icon(
                              cart.containsProduct(product.id)
                                  ? Icons.check
                                  : Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_outline, size: 80, color: AppColors.grey300),
          const SizedBox(height: AppSizes.spacingLG),
          Text(AppStrings.emptyWishlist,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSizes.spacingSM),
          Text(AppStrings.emptyWishlistSubtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSizes.spacingXXL),
          OutlinedButton(
            onPressed: Get.back,
            child: const Text(AppStrings.discoverProducts),
          ),
        ],
      ),
    );
  }
}
