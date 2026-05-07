import 'package:grocery_app/data/datasource/mock_data.dart';
import 'package:grocery_app/data/models/banner_model.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/models/promo_code_model.dart';
import 'package:grocery_app/data/models/review_model.dart';

/// Provides product, category, banner, and promo data.
/// Uses mock data as the source — replace with API calls for production.
class ProductRepository {
  const ProductRepository();

  // ─── Banners ──────────────────────────────────────────────────────────────

  Future<List<BannerModel>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockData.banners;
  }

  // ─── Categories ───────────────────────────────────────────────────────────

  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.categories;
  }

  // ─── Products ─────────────────────────────────────────────────────────────

  Future<List<ProductModel>> getAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return MockData.products;
  }

  Future<List<ProductModel>> getPopularProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockData.getPopularProducts();
  }

  Future<List<ProductModel>> getRecommendedProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockData.getRecommendedProducts();
  }

  Future<List<ProductModel>> getFlashDeals() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.getFlashDeals();
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return MockData.getProductsByCategory(categoryId);
  }

  Future<ProductModel?> getProductById(String productId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return MockData.products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.searchProducts(query);
  }

  // ─── Reviews ──────────────────────────────────────────────────────────────

  Future<List<ReviewModel>> getProductReviews(String productId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockData.getReviewsForProduct(productId);
  }

  // ─── Promo Codes ──────────────────────────────────────────────────────────

  Future<PromoCodeModel?> validatePromoCode(String code) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockData.findPromoCode(code);
  }
}
