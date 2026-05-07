import '../datasource/mock_grocery_datasource.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class CatalogRepository {
  CatalogRepository(this._dataSource);

  final MockGroceryDataSource _dataSource;

  Future<List<BannerModel>> getBanners() => _dataSource.fetchBanners();

  Future<List<CategoryModel>> getCategories() => _dataSource.fetchCategories();

  Future<List<ProductModel>> getProducts() => _dataSource.fetchProducts();
}
