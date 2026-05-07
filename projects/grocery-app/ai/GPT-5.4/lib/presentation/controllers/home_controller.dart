import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/local_storage_service.dart';
import '../../data/models/banner_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/catalog_repository.dart';

class HomeController extends GetxController {
  HomeController(this._catalogRepository, this._storageService);

  final CatalogRepository _catalogRepository;
  final LocalStorageService _storageService;

  final isLoading = true.obs;
  final hasError = false.obs;
  final searchQuery = ''.obs;
  final selectedCategoryId = ''.obs;
  final banners = <BannerModel>[].obs;
  final categories = <CategoryModel>[].obs;
  final products = <ProductModel>[].obs;
  final favoriteIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _restoreFavorites();
    loadHome();
  }

  Future<void> loadHome() async {
    try {
      hasError.value = false;
      isLoading.value = true;
      final results = await Future.wait<dynamic>([
        _catalogRepository.getBanners(),
        _catalogRepository.getCategories(),
        _catalogRepository.getProducts(),
      ]);
      banners.assignAll(results[0] as List<BannerModel>);
      categories.assignAll(results[1] as List<CategoryModel>);
      products.assignAll(results[2] as List<ProductModel>);
      if (categories.isNotEmpty && selectedCategoryId.value.isEmpty) {
        selectedCategoryId.value = categories.first.id;
      }
    } catch (_) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchQuery(String value) {
    searchQuery.value = value;
  }

  void selectCategory(String categoryId) {
    if (selectedCategoryId.value == categoryId) {
      selectedCategoryId.value = '';
      return;
    }
    selectedCategoryId.value = categoryId;
  }

  List<ProductModel> get filteredProducts {
    final query = searchQuery.value.toLowerCase();
    return products.where((product) {
      final matchesCategory = selectedCategoryId.value.isEmpty ||
        product.categoryId == selectedCategoryId.value;
      final matchesQuery = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  List<ProductModel> get popularProducts =>
      products.where((product) => product.isPopular).toList();

  List<ProductModel> get recommendedProducts =>
      products.where((product) => product.isRecommended).toList();

  List<ProductModel> get discountedProducts =>
      products.where((product) => product.hasDiscount).toList();

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  Future<void> toggleFavorite(String productId) async {
    final updated = Set<String>.from(favoriteIds);
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    favoriteIds.value = updated;
    await _storageService.writeStringList(
      StorageKeys.favoriteIds,
      updated.toList(growable: false),
    );
  }

  void _restoreFavorites() {
    favoriteIds.value = _storageService.readStringList(StorageKeys.favoriteIds).toSet();
  }
}
