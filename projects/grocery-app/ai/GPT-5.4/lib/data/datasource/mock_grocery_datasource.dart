import 'dart:convert';

import '../api_client/mock_api_client.dart';
import '../models/address_model.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/payment_method_model.dart';
import '../models/product_model.dart';
import '../models/user_profile_model.dart';

class MockGroceryDataSource {
  MockGroceryDataSource(this._client);

  final MockApiClient _client;

  Future<List<BannerModel>> fetchBanners() async {
    final response = await _client.get('banners');
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _client.get('categories');
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> fetchProducts() async {
    final response = await _client.get('products');
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<OrderModel>> fetchOrders() async {
    final response = await _client.get('orders');
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<AddressModel>> fetchAddresses() async {
    final response = await _client.get('addresses');
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((item) => AddressModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<PaymentMethodModel>> fetchPaymentMethods() async {
    final response = await _client.get('payments');
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((item) =>
            PaymentMethodModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<UserProfileModel> fetchProfile() async {
    final response = await _client.get('profile');
    final decoded = jsonDecode(response) as Map<String, dynamic>;
    return UserProfileModel.fromJson(decoded);
  }
}
