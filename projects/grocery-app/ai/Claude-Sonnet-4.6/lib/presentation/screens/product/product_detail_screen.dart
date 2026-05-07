import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/product_controller.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Product detail screen.
class ProductDetailScreen extends GetView<ProductController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (controller.product.value == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(controller.errorMessage.value.isNotEmpty
                  ? controller.errorMessage.value
                  : 'Product not found'),
            ),
          );
        }

        final product = controller.product.value!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // App bar with image
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.grey100),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.grey100,
                      child: const Icon(Icons.image_outlined,
                          size: 80, color: AppColors.grey400),
                    ),
                  ),
                ),
                actions: [
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        controller.isInWishlist
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: controller.isInWishlist
                            ? AppColors.error
                            : Colors.white,
                      ),
                      onPressed: controller.toggleWishlist,
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingLG),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + category
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.unit,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Obx(
                                () => Text(
                                  Helpers.formatPrice(controller.displayPrice),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              if (product.isOnSale)
                                Row(
                                  children: [
                                    Text(
                                      Helpers.formatPrice(product.price),
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: AppSizes.fontSM,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.errorLight,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '${product.discountPercent!.toInt()}% OFF',
                                        style: const TextStyle(
                                          color: AppColors.error,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.spacingLG),

                      // Rating row
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating,
                            itemBuilder: (_, __) => const Icon(
                                Icons.star, color: AppColors.warning),
                            itemCount: 5,
                            itemSize: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            Helpers.formatRating(product.rating),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${Helpers.formatCount(product.reviewCount)} reviews)',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          const Spacer(),
                          if (!product.inStock)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.errorLight,
                                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                              ),
                              child: const Text(
                                AppStrings.outOfStock,
                                style: TextStyle(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppSizes.fontSM),
                              ),
                            ),
                        ],
                      ),

                      const Divider(height: AppSizes.spacingXXL),

                      // Variants
                      if (product.variants.isNotEmpty) ...[
                        Text(
                          AppStrings.selectVariant,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.spacingMD),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: product.variants.map((v) {
                              final isSelected =
                                  controller.selectedVariant.value?.id == v.id;
                              return GestureDetector(
                                onTap: () => controller.selectVariant(v),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusMD),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.grey300,
                                    ),
                                  ),
                                  child: Text(
                                    v.extraCost != null && v.extraCost! > 0
                                        ? '${v.label} (+${Helpers.formatPrice(v.extraCost!)})'
                                        : v.label,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      fontSize: AppSizes.fontSM,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const Divider(height: AppSizes.spacingXXL),
                      ],

                      // Description
                      Text(
                        AppStrings.description,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSizes.spacingMD),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                      ),

                      const SizedBox(height: AppSizes.spacingXXL),

                      // Reviews
                      if (controller.reviews.isNotEmpty) ...[
                        Text(
                          AppStrings.reviews,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.spacingMD),
                        ...controller.reviews.take(3).map(
                              (r) => _ReviewTile(review: r),
                            ),
                      ],

                      // Similar products
                      if (controller.similarProducts.isNotEmpty) ...[
                        const Divider(height: AppSizes.spacingXXL),
                        Text(
                          AppStrings.youMayAlsoLike,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.spacingMD),
                        SizedBox(
                          height: 210,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemCount: controller.similarProducts.length,
                            itemBuilder: (_, i) => _SimilarProductCard(
                                product: controller.similarProducts[i]),
                          ),
                        ),
                      ],

                      const SizedBox(height: 100), // Bottom padding for FAB
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom add to cart bar
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSizes.paddingLG, 8, AppSizes.paddingLG, AppSizes.paddingMD),
              child: Row(
                children: [
                  // Quantity selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey200),
                      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: controller.decreaseQuantity,
                        ),
                        Obx(
                          () => SizedBox(
                            width: 32,
                            child: Text(
                              '${controller.quantity.value}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: controller.increaseQuantity,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: product.inStock
                          ? () {
                              Get.find<CartController>().addItem(
                                product,
                                quantity: controller.quantity.value,
                                variant: controller.selectedVariant.value,
                              );
                            }
                          : null,
                      child: Text(product.inStock
                          ? AppStrings.addToCart
                          : AppStrings.outOfStock),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Review tile ──────────────────────────────────────────────────────────────

class _ReviewTile extends StatelessWidget {
  final ReviewModel review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingMD),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: review.userAvatarUrl != null
                ? NetworkImage(review.userAvatarUrl!)
                : null,
            backgroundColor: AppColors.grey200,
            child: review.userAvatarUrl == null
                ? Text(
                    review.userName.isNotEmpty ? review.userName[0] : '?',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text(
                      Helpers.timeAgo(review.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemSize: 14,
                  itemBuilder: (_, __) =>
                      const Icon(Icons.star, color: AppColors.warning),
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Similar Product Card ─────────────────────────────────────────────────────

class _SimilarProductCard extends StatelessWidget {
  final ProductModel product;
  const _SimilarProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetail,
          arguments: {'product': product}),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: context.isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppSizes.radiusLG)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.grey100),
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.grey100),
              ),
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
                  Text(
                    Helpers.formatPrice(product.effectivePrice),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSizes.fontSM,
                    ),
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
