  import 'package:grocery_app/core/network/product_network.dart';
  import 'package:grocery_app/core/services/product_service.dart';

  class ProductRepository extends ProductService {
    @override
    Future<List<Product>> fetchProducts() => super.fetchProducts();
  }