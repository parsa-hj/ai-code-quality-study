import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';

/// Manages search query, results, and history.
/// Note: renamed to GrocerySearchController to avoid conflict with
/// Flutter's built-in SearchController.
class GrocerySearchController extends GetxController {
  final ProductRepository _productRepository;

  GrocerySearchController(this._productRepository);

  // ─── State ────────────────────────────────────────────────────────────────
  final RxString query = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> results = <ProductModel>[].obs;
  final RxList<String> searchHistory = <String>[].obs;

  static const List<String> _popularSearches = [
    'avocado',
    'organic milk',
    'sourdough',
    'salmon',
    'blueberries',
    'greek yogurt',
    'olive oil',
    'pasta',
  ];

  List<String> get popularSearches => _popularSearches;
  bool get hasQuery => query.isNotEmpty;
  bool get hasResults => results.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadHistory();
    debounce(query, _search, time: const Duration(milliseconds: 400));
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  void onQueryChanged(String value) => query.value = value;

  void clearQuery() {
    query.value = '';
    results.clear();
  }

  Future<void> _search(String q) async {
    if (q.trim().isEmpty) {
      results.clear();
      return;
    }
    isLoading.value = true;
    try {
      results.value = await _productRepository.searchProducts(q.trim());
    } finally {
      isLoading.value = false;
    }
  }

  void submitSearch(String q) {
    if (q.trim().isEmpty) return;
    query.value = q.trim();
    _addToHistory(q.trim());
  }

  void _addToHistory(String q) {
    searchHistory.remove(q);
    searchHistory.insert(0, q);
    if (searchHistory.length > AppConstants.maxSearchHistory) {
      searchHistory.removeLast();
    }
    Get.find<StorageService>()
        .setStringList(AppConstants.keySearchHistory, searchHistory.toList());
  }

  void _loadHistory() {
    searchHistory.value = Get.find<StorageService>()
        .getStringList(AppConstants.keySearchHistory);
  }

  void removeFromHistory(String q) {
    searchHistory.remove(q);
    Get.find<StorageService>()
        .setStringList(AppConstants.keySearchHistory, searchHistory.toList());
  }

  void clearHistory() {
    searchHistory.clear();
    Get.find<StorageService>()
        .remove(AppConstants.keySearchHistory);
  }
}
