import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/responsive_helper.dart';
import '../../data/models/product_model.dart';
import '../../routes/app_routes.dart';
import '../controllers/cart_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/app_text_field.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_chip.dart';
import '../widgets/error_state_view.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import '../widgets/skeleton_box.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('FreshCart'),
        actions: [
          Obx(
            () => Badge(
              isLabelVisible: cartController.totalItems > 0,
              label: Text('${cartController.totalItems}'),
              child: IconButton(
                onPressed: () => Get.toNamed(AppRoutes.cart),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.orders),
            icon: const Icon(Icons.receipt_long_outlined),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.profile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const _HomeLoadingView();
        }
        if (controller.hasError.value) {
          return ErrorStateView(
            message: 'Could not load groceries right now.',
            onRetry: controller.loadHome,
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadHome,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _TopIntro(cartController: cartController),
              const SizedBox(height: 20),
              AppTextField(
                hint: 'Search fruits, dairy, pantry and more',
                prefixIcon: Icons.search,
                onChanged: controller.setSearchQuery,
                suffix: IconButton(
                  onPressed: () => controller.setSearchQuery(''),
                  icon: const Icon(Icons.tune_rounded),
                ),
              ),
              const SizedBox(height: 24),
              BannerCarousel(banners: controller.banners),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Categories',
                subtitle: 'Shop by department',
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 54,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return Obx(
                      () => CategoryChip(
                        category: category,
                        isSelected: controller.selectedCategoryId.value == category.id,
                        onTap: () => controller.selectCategory(category.id),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              _ProductRail(
                title: 'Popular today',
                subtitle: 'Fast moving favorites with top ratings',
                products: controller.popularProducts,
              ),
              const SizedBox(height: 28),
              _ProductRail(
                title: 'Recommended for you',
                subtitle: 'Picked from your recent taste profile',
                products: controller.recommendedProducts,
              ),
              const SizedBox(height: 28),
              _ProductRail(
                title: 'Discounts you should not miss',
                subtitle: 'Weekly value picks and fresh markdowns',
                products: controller.discountedProducts,
              ),
              const SizedBox(height: 28),
              SectionHeader(
                title: 'Browse results',
                subtitle: controller.selectedCategoryId.value.isEmpty
                    ? 'All groceries'
                    : 'Filtered by your selected category',
              ),
              const SizedBox(height: 16),
              _ResponsiveProductGrid(products: controller.filteredProducts),
            ],
          ),
        );
      }),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) {
            Get.toNamed(AppRoutes.cart);
          } else if (index == 2) {
            Get.toNamed(AppRoutes.orders);
          } else if (index == 3) {
            Get.toNamed(AppRoutes.profile);
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _TopIntro extends StatelessWidget {
  const _TopIntro({required this.cartController});

  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery in 12 minutes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Build your basket from premium produce, bakery staples, and pantry essentials.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                        .withOpacity(0.86),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const Icon(Icons.shopping_basket_outlined, color: Colors.white),
                const SizedBox(height: 6),
                Obx(
                  () => Text(
                    '${cartController.totalItems} items',
                    style: const TextStyle(color: Colors.white),
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

class _ProductRail extends GetView<HomeController> {
  const _ProductRail({
    required this.title,
    required this.subtitle,
    required this.products,
  });

  final String title;
  final String subtitle;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, subtitle: subtitle),
        const SizedBox(height: 16),
        SizedBox(
          height: 308,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return SizedBox(
                width: 230,
                child: Obx(
                  () => ProductCard(
                    product: product,
                    isFavorite: controller.isFavorite(product.id),
                    onFavoriteTap: () => controller.toggleFavorite(product.id),
                    onTap: () => Get.toNamed(AppRoutes.product, arguments: product),
                    onAddTap: () => cartController.addToCart(
                      product: product,
                      variant: product.variants.first,
                      quantity: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ResponsiveProductGrid extends GetView<HomeController> {
  const _ResponsiveProductGrid({required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Center(child: Text('No products match your current filters.')),
      );
    }

    final cartController = Get.find<CartController>();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.gridCount(context),
        mainAxisExtent: 290,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Obx(
          () => ProductCard(
            product: product,
            isFavorite: controller.isFavorite(product.id),
            onFavoriteTap: () => controller.toggleFavorite(product.id),
            onTap: () => Get.toNamed(AppRoutes.product, arguments: product),
            onAddTap: () => cartController.addToCart(
              product: product,
              variant: product.variants.first,
              quantity: 1,
            ),
          ),
        );
      },
    );
  }
}

class _HomeLoadingView extends StatelessWidget {
  const _HomeLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SkeletonBox(height: 120, radius: 28),
        SizedBox(height: 18),
        SkeletonBox(height: 56, radius: 20),
        SizedBox(height: 18),
        SkeletonBox(height: 210, radius: 28),
        SizedBox(height: 18),
        SkeletonBox(height: 56),
        SizedBox(height: 18),
        SkeletonBox(height: 280, radius: 28),
      ],
    );
  }
}
