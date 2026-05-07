import 'dart:async';

import '../../core/constants/app_constants.dart';
import '../datasource/mock_json_data.dart';

class MockApiClient {
  Future<String> get(String endpoint) async {
    await Future<void>.delayed(AppConstants.mockDelay);
    switch (endpoint) {
      case 'banners':
        return mockBannersJson;
      case 'categories':
        return mockCategoriesJson;
      case 'products':
        return mockProductsJson;
      case 'orders':
        return mockOrdersJson;
      case 'addresses':
        return mockAddressesJson;
      case 'payments':
        return mockPaymentsJson;
      case 'profile':
        return mockProfileJson;
      default:
        throw UnsupportedError('Unsupported mock endpoint: $endpoint');
    }
  }
}
