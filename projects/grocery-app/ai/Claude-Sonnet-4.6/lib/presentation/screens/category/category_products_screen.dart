import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Shows products for a selected category.
class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final RxBool isLoading = true.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  late CategoryModel category;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map?;
    category = args?['category'] as CategoryModel? ?? CategoryModel(
      id: '',
      name: 'Products',
      imageUrl: '',
      color: AppColors.primary,
      productCount: 0,
    );
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    final repo = Get.find<ProductRepository>();
    products.value = await repo.getProductsByCategory(category.id);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Obx(
        () => isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.category_outlined,
                            size: 72, color: AppColors.grey300),
                        const SizedBox(height: 16),
                        Text(AppStrings.noProducts,
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(AppSizes.paddingLG),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSizes.spacingMD,
                      crossAxisSpacing: AppSizes.spacingMD,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (_, i) =>
                        _ProductCard(product: products[i]),
                  ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
