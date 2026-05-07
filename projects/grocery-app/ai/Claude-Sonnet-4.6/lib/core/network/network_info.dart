import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// Checks and monitors internet connectivity.
/// Registered as a singleton in InitialBinding.
class NetworkInfo extends GetxService {
  final Connectivity _connectivity;

  NetworkInfo(this._connectivity);

  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _monitorConnectivity();
  }

  /// Listens to connectivity changes and updates [isConnected].
  void _monitorConnectivity() {
    _connectivity.onConnectivityChanged.listen((results) {
      isConnected.value = results.any((r) => r != ConnectivityResult.none);
    });
  }

  /// Performs a one-time connectivity check.
  Future<bool> get hasConnection async {
    final result = await _connectivity.checkConnectivity();
    final connected = result.any((r) => r != ConnectivityResult.none);
    isConnected.value = connected;
    return connected;
  }
}
