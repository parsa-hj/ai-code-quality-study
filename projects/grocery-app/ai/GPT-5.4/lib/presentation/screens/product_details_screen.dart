import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_formatters.dart';
import '../../data/models/product_model.dart';
import '../../widgets/app_page_shell.dart';
import '../controllers/cart_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/app_button.dart';
import '../widgets/app_network_image.dart';
import '../widgets/quantity_selector.dart';

class ProductDetailsScreen extends GetView<ProductController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();
    final product = Get.arguments as ProductModel? ??
        (homeController.products.isNotEmpty ? homeController.products.first : null);

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('No product selected.')),
      );
    }

    controller.setup(product);

    return AppPageShell(
      title: product.name,
      actions: [
        Obx(
          () => IconButton(
            onPressed: () => homeController.toggleFavorite(product.id),
            icon: Icon(
              homeController.isFavorite(product.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
          ),
        ),
      ],
      child: ListView(
        children: [
          _Gallery(product: product),
          const SizedBox(height: 20),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(product.description),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                AppFormatters.currency(product.price),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 12),
              if (product.hasDiscount)
                Text(
                  AppFormatters.currency(product.originalPrice),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              const Spacer(),
              const Icon(Icons.star_rounded),
              Text('${product.rating} (${product.reviewCount})'),
            ],
          ),
          const SizedBox(height: 20),
          Text('Variants', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Obx(
            () => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: product.variants
                  .map(
                    (variant) => ChoiceChip(
                      label: Text(variant),
                      selected: controller.selectedVariant.value == variant,
                      onSelected: (_) => controller.chooseVariant(variant),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Obx(
                () => QuantitySelector(
                  quantity: controller.quantity.value,
                  onAdd: controller.increment,
                  onRemove: controller.decrement,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Obx(
                  () => AppButton(
                    label:
                        'Add ${controller.quantity.value} to cart',
                    onPressed: () => cartController.addToCart(
                      product: product,
                      variant: controller.selectedVariant.value,
                      quantity: controller.quantity.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text('Ratings & reviews', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 14),
          ...product.reviews.map(
            (review) => Card(
              child: ListTile(
                title: Text(review.author),
                subtitle: Text(review.comment),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${review.rating}'),
                    Text(review.date),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Gallery extends GetView<ProductController> {
  const _Gallery({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => AppNetworkImage(
            imageUrl: controller.selectedImage.value,
            height: 320,
            width: double.infinity,
            borderRadius: 32,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: product.gallery.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final image = product.gallery[index];
              return GestureDetector(
                onTap: () => controller.chooseImage(image),
                child: AppNetworkImage(
                  imageUrl: image,
                  width: 76,
                  height: 76,
                  borderRadius: 20,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
