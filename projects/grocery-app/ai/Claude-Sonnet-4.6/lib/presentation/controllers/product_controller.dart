import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';

/// Manages state for the product detail screen.
class ProductController extends GetxController {
  final ProductRepository _productRepository;
  final WishlistController _wishlistController;

  ProductController(this._productRepository, this._wishlistController);

  // ─── State ────────────────────────────────────────────────────────────────
  final Rx<ProductModel?> product = Rx<ProductModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxInt selectedImageIndex = 0.obs;
  final Rx<ProductVariant?> selectedVariant = Rx<ProductVariant?>(null);
  final RxInt quantity = 1.obs;
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxBool reviewsLoading = false.obs;
  final RxList<ProductModel> similarProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final productId = args['productId'] as String?;
      if (productId != null) {
        loadProduct(productId);
      } else if (args['product'] is ProductModel) {
        _setProduct(args['product'] as ProductModel);
      }
    } else if (args is ProductModel) {
      _setProduct(args);
    }
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  Future<void> loadProduct(String productId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final p = await _productRepository.getProductById(productId);
      if (p != null) {
        _setProduct(p);
      } else {
        errorMessage.value = 'Product not found.';
      }
    } catch (_) {
      errorMessage.value = AppStrings.somethingWrong;
    } finally {
      isLoading.value = false;
    }
  }

  void _setProduct(ProductModel p) {
    product.value = p;
    isLoading.value = false;
    if (p.variants.isNotEmpty) selectedVariant.value = p.variants.first;
    _loadReviews(p.id);
    _loadSimilar(p.categoryId);
  }

  Future<void> _loadReviews(String productId) async {
    reviewsLoading.value = true;
    try {
      reviews.value = await _productRepository.getProductReviews(productId);
    } finally {
      reviewsLoading.value = false;
    }
  }

  Future<void> _loadSimilar(String categoryId) async {
    final allInCategory =
        await _productRepository.getProductsByCategory(categoryId);
    similarProducts.value = allInCategory
        .where((p) => p.id != product.value?.id)
        .take(10)
        .toList();
  }

  void selectImage(int index) => selectedImageIndex.value = index;

  void selectVariant(ProductVariant variant) =>
      selectedVariant.value = variant;

  void increaseQuantity() {
    if (quantity.value < AppConstants.maxItemQuantity) {
      quantity.value++;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) quantity.value--;
  }

  void toggleWishlist() {
    if (product.value != null) {
      _wishlistController.toggle(product.value!);
    }
  }

  bool get isInWishlist =>
      product.value != null
          ? _wishlistController.isInWishlist(product.value!.id)
          : false;

  /// The currently displayed price (base + variant extra cost).
  double get displayPrice {
    final base = product.value?.effectivePrice ?? 0;
    final extra = selectedVariant.value?.extraCost ?? 0;
    return base + extra;
  }
}
