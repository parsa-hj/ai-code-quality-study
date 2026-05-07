  import 'package:http/http.dart' as http;

  class ApiClient {
    final String _baseUrl = Constants.API_URL;
    final String _cartApiUrl = '${_baseUrl}/cart';

    Future<List<Product>> getCart() async {
      final response = await http.get(Uri.parse(_cartApiUrl));
      return Product.fromJsonList(response.body);
    }
  }