import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/search_controller.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Search screen.
class SearchScreen extends GetView<GrocerySearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.paddingMD,
        title: TextField(
          controller: textCtrl,
          autofocus: false,
          decoration: InputDecoration(
            hintText: AppStrings.searchHint,
            prefixIcon: const Icon(Icons.search_outlined),
            suffixIcon: Obx(
              () => controller.hasQuery
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        textCtrl.clear();
                        controller.clearQuery();
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            isDense: true,
          ),
          onChanged: controller.onQueryChanged,
          onSubmitted: controller.submitSearch,
          textInputAction: TextInputAction.search,
        ),
      ),
      body: Obx(
        () {
          if (!controller.hasQuery) {
            return _EmptySearchView(controller: controller, textCtrl: textCtrl);
          }
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!controller.hasResults) {
            return _NoResults(query: controller.query.value);
          }
          return _ResultsGrid(products: controller.results);
        },
      ),
    );
  }
}

class _EmptySearchView extends StatelessWidget {
  final GrocerySearchController controller;
  final TextEditingController textCtrl;

  const _EmptySearchView(
      {required this.controller, required this.textCtrl});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      children: [
        // Search history
        if (controller.searchHistory.isNotEmpty) ...[
          _SectionTitle(
            title: AppStrings.recentSearches,
            action: TextButton(
              onPressed: controller.clearHistory,
              child: const Text(AppStrings.clearAll),
            ),
          ),
          ...controller.searchHistory.map(
            (q) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.history, color: AppColors.textSecondary),
              title: Text(q),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () => controller.removeFromHistory(q),
              ),
              onTap: () {
                textCtrl.text = q;
                controller.submitSearch(q);
              },
            ),
          ),
          const Divider(height: AppSizes.spacingXXL),
        ],

        // Popular searches
        _SectionTitle(title: AppStrings.popularSearches),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.popularSearches.map((q) {
            return ActionChip(
              label: Text(q),
              onPressed: () {
                textCtrl.text = q;
                controller.submitSearch(q);
              },
              backgroundColor:
                  context.isDark ? AppColors.darkSurface : AppColors.grey100,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Widget? action;

  const _SectionTitle({required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  final String query;
  const _NoResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_outlined,
              size: 72, color: AppColors.grey300),
          const SizedBox(height: AppSizes.spacingLG),
          Text(
            AppStrings.noResultsFor,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '"$query"',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _ResultsGrid extends StatelessWidget {
  final List<ProductModel> products;
  const _ResultsGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSizes.spacingMD,
        crossAxisSpacing: AppSizes.spacingMD,
        childAspectRatio: 0.72,
      ),
      itemCount: products.length,
      itemBuilder: (_, i) {
        final product = products[i];
        return GestureDetector(
          onTap: () =>
              Get.toNamed(AppRoutes.productDetail, arguments: {'product': product}),
          child: Container(
            decoration: BoxDecoration(
              color:
                  context.isDark ? AppColors.darkSurface : Colors.white,
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
                                fontSize: AppSizes.fontSM),
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
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusSM),
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
      },
    );
  }
}
