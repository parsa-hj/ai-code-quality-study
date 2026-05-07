import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/home_controller.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/presentation/screens/product/product_detail_screen.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Home screen — banners, categories, products, flash deals.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const _HomeSkeleton()
            : RefreshIndicator(
                onRefresh: controller.loadAll,
                color: AppColors.primary,
                child: CustomScrollView(
                  slivers: [
                    _HomeAppBar(controller: controller),
                    SliverToBoxAdapter(child: _BannerCarousel(controller: controller)),
                    SliverToBoxAdapter(child: _SectionHeader(title: AppStrings.categories, onSeeAll: null)),
                    SliverToBoxAdapter(child: _CategoriesRow(controller: controller)),
                    SliverToBoxAdapter(child: _SectionHeader(title: AppStrings.flashDeals, onSeeAll: null)),
                    _ProductsHorizontalList(products: controller.flashDeals),
                    SliverToBoxAdapter(child: _SectionHeader(title: AppStrings.popularProducts, onSeeAll: null)),
                    _ProductsHorizontalList(products: controller.popularProducts),
                    SliverToBoxAdapter(child: _SectionHeader(title: AppStrings.recommended, onSeeAll: null)),
                    _ProductGrid(products: controller.recommendedProducts),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
                ),
              ),
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _HomeAppBar extends StatelessWidget {
  final HomeController controller;
  const _HomeAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor:
          context.isDark ? AppColors.darkBackground : Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.greeting,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textSecondary),
          ),
          Obx(
            () => Text(
              Get.find<AuthService>().currentUser.value?.name.split(' ').first ??
                  AppStrings.appName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => Get.toNamed(AppRoutes.notifications),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_outline),
          onPressed: () => Get.toNamed(AppRoutes.wishlist),
        ),
      ],
    );
  }
}

// ─── Banner Carousel ─────────────────────────────────────────────────────────

class _BannerCarousel extends StatelessWidget {
  final HomeController controller;
  const _BannerCarousel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.banners.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMD),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: controller.banners.length,
              options: CarouselOptions(
                height: 180,
                viewportFraction: 0.88,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                enlargeCenterPage: true,
                onPageChanged: (i, _) => controller.bannerIndex.value = i,
              ),
              itemBuilder: (_, i, __) {
                final banner = controller.banners[i];
                return GestureDetector(
                  onTap: banner.actionRoute != null
                      ? () => Get.toNamed(banner.actionRoute!)
                      : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: banner.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: AppColors.grey200,
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: AppColors.grey200,
                            child: const Icon(Icons.image_outlined,
                                size: 40, color: AppColors.grey400),
                          ),
                        ),
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        // Text
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                banner.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSizes.fontLG,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (banner.subtitle != null)
                                Text(
                                  banner.subtitle!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
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
              },
            ),
            const SizedBox(height: 10),
            Obx(
              () => AnimatedSmoothIndicator(
                activeIndex: controller.bannerIndex.value,
                count: controller.banners.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.grey300,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionHeader({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLG,
        AppSizes.paddingLG,
        AppSizes.paddingLG,
        AppSizes.paddingSM,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text(AppStrings.seeAll),
            ),
        ],
      ),
    );
  }
}

// ─── Categories Row ───────────────────────────────────────────────────────────

class _CategoriesRow extends StatelessWidget {
  final HomeController controller;
  const _CategoriesRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
          separatorBuilder: (_, __) =>
              const SizedBox(width: AppSizes.spacingMD),
          itemCount: controller.categories.length,
          itemBuilder: (_, i) {
            final cat = controller.categories[i];
            return GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.categoryProducts,
                arguments: {'category': cat},
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: cat.color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: cat.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Center(
                          child: Icon(
                            Icons.category_outlined,
                            color: cat.color,
                          ),
                        ),
                        errorWidget: (_, __, ___) => Center(
                          child: Icon(Icons.category_outlined, color: cat.color),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Horizontal Products List ─────────────────────────────────────────────────

class _ProductsHorizontalList extends StatelessWidget {
  final RxList<ProductModel> products;
  const _ProductsHorizontalList({required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.productCardHeight + 16,
        child: Obx(
          () => ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
            separatorBuilder: (_, __) =>
                const SizedBox(width: AppSizes.spacingMD),
            itemCount: products.length,
            itemBuilder: (_, i) => _ProductCard(product: products[i]),
          ),
        ),
      ),
    );
  }
}

// ─── Product Grid ──────────────────────────────────────────────────────────────

class _ProductGrid extends StatelessWidget {
  final RxList<ProductModel> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (_, i) => _ProductCard(product: products[i]),
            childCount: products.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSizes.spacingMD,
            crossAxisSpacing: AppSizes.spacingMD,
            childAspectRatio: 0.72,
          ),
        ),
      ),
    );
  }
}

// ─── Product Card ──────────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final isDark = context.isDark;

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.productDetail,
        arguments: {'product': product},
      ),
      child: Container(
        width: AppSizes.productCardWidth,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusLG)),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    height: AppSizes.productCardWidth * 0.75,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.grey100,
                      child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.grey100,
                      child: const Icon(Icons.image_outlined,
                          color: AppColors.grey400),
                    ),
                  ),
                ),
                if (product.isOnSale)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      ),
                      child: Text(
                        '${product.discountPercent!.toInt()}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingSM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.unit,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Helpers.formatPrice(product.effectivePrice),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.fontMD,
                            ),
                          ),
                          if (product.isOnSale)
                            Text(
                              Helpers.formatPrice(product.price),
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      Obx(
                        () => cart.containsProduct(product.id)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.radiusSM),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove,
                                          color: Colors.white, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minWidth: 28, minHeight: 28),
                                      onPressed: () {
                                        final qty =
                                            cart.quantityOfProduct(product.id);
                                        final item = cart.items.firstWhere(
                                            (i) => i.product.id == product.id);
                                        cart.updateQuantity(item.id, qty - 1);
                                      },
                                    ),
                                    Text(
                                      '${cart.quantityOfProduct(product.id)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add,
                                          color: Colors.white, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minWidth: 28, minHeight: 28),
                                      onPressed: () =>
                                          cart.addItem(product, quantity: 1),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () => cart.addItem(product),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusSM),
                                  ),
                                  child: const Icon(Icons.add,
                                      color: Colors.white, size: 18),
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

// ─── Skeleton ─────────────────────────────────────────────────────────────────

class _HomeSkeleton extends StatelessWidget {
  const _HomeSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        children: [
          Container(height: 50, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 180, color: Colors.white,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                  color: Colors.white)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (_) => Column(children: [
                Container(width: 64, height: 64, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                const SizedBox(height: 4),
                Container(height: 10, width: 48, color: Colors.white),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
