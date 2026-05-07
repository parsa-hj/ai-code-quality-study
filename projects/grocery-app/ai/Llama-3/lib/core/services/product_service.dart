  import 'package:http/http.dart' as http;

  class ProductService {
    final String _baseUrl = Constants.API_URL;
    final String _productApiUrl = '${_baseUrl}/products';

    Future<List<Product>> fetchProducts() async {
      final response = await http.get(Uri.parse(_productApiUrl));
      return Product.fromJsonList(response.body);
    }
  }

  class ProductRepository extends ProductService {
    @override
    Future<List<Product>> fetchProducts() => super.fetchProducts();
  }