  class Constants {
    static const String API_URL = 'https://api.example.com';
    static const String PRODUCT_API_URL = '${API_URL}/products';
    static const String CART_API_URL = '${API_URL}/cart';

    static const String SHARED_PREFERENCES_KEY = 'grocery_app_settings';
  }

  lib/core/network.dart
  import 'package:http/http.dart' as http;

  class Network {
    final String _baseUrl = Constants.API_URL;
    final String _productApiUrl = '${_baseUrl}/products';

    Future<List<Product>> fetchProducts() async {
      final response = await http.get(Uri.parse(_productApiUrl));
      return Product.fromJsonList(response.body);
    }
  }

  class Product {
    final int id;
    final String name;

    const Product(this.id, this.name);

    factory Product.fromJson(List<dynamic> json) {
      if (json.isEmpty) return null;
      return Product(json[0]['id'], json[0]['name']);
    }

    List<Product> toJson() => [Product(id, name)];
  }