import '../datasource/mock_grocery_datasource.dart';
import '../models/address_model.dart';
import '../models/order_model.dart';
import '../models/payment_method_model.dart';

class OrderRepository {
  OrderRepository(this._dataSource);

  final MockGroceryDataSource _dataSource;

  Future<List<OrderModel>> getOrders() => _dataSource.fetchOrders();

  Future<List<AddressModel>> getAddresses() => _dataSource.fetchAddresses();

  Future<List<PaymentMethodModel>> getPaymentMethods() {
    return _dataSource.fetchPaymentMethods();
  }
}
