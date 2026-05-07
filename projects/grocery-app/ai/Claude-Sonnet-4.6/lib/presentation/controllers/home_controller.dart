import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/data/models/banner_model.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';

/// Manages state for the Home screen.
class HomeController extends GetxController {
  final ProductRepository _productRepository;

  HomeController(this._productRepository);

  // ─── State ────────────────────────────────────────────────────────────────
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ProductModel> popularProducts = <ProductModel>[].obs;
  final RxList<ProductModel> recommendedProducts = <ProductModel>[].obs;
  final RxList<ProductModel> flashDeals = <ProductModel>[].obs;

  final RxInt bannerIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  Future<void> loadHomeData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final results = await Future.wait([
        _productRepository.getBanners(),
        _productRepository.getCategories(),
        _productRepository.getPopularProducts(),
        _productRepository.getRecommendedProducts(),
        _productRepository.getFlashDeals(),
      ]);

      banners.value = results[0] as List<BannerModel>;
      categories.value = results[1] as List<CategoryModel>;
      popularProducts.value = results[2] as List<ProductModel>;
      recommendedProducts.value = results[3] as List<ProductModel>;
      flashDeals.value = results[4] as List<ProductModel>;
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = AppStrings.somethingWrong;
    } finally {
      isLoading.value = false;
    }
  }

  void onBannerChanged(int index) => bannerIndex.value = index;

  String get greeting => Helpers.greeting();
}
