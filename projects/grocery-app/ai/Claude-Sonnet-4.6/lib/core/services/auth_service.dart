import 'dart:convert';
import 'package:get/get.dart';
import 'package:grocery_app/core/constants/app_constants.dart';
import 'package:grocery_app/core/services/storage_service.dart';
import 'package:grocery_app/data/models/user_model.dart';

/// Manages authentication state across the app.
/// Other controllers can read [currentUser] and [isLoggedIn].
class AuthService extends GetxService {
  final StorageService _storage;

  AuthService(this._storage);

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = false.obs;
  final RxString authToken = ''.obs;

  Future<AuthService> init() async {
    _loadSavedSession();
    return this;
  }

  /// Reads persisted session from storage on app launch.
  void _loadSavedSession() {
    final loggedIn = _storage.getBool(AppConstants.keyIsLoggedIn);
    if (loggedIn) {
      final userData = _storage.getObject(AppConstants.keyUserData);
      if (userData != null) {
        currentUser.value = UserModel.fromJson(userData);
      }
      authToken.value =
          _storage.getString(AppConstants.keyAuthToken) ?? '';
      isLoggedIn.value = currentUser.value != null;
    }
  }

  /// Called after a successful login. Persists the session.
  Future<void> saveSession(UserModel user, String token) async {
    currentUser.value = user;
    authToken.value = token;
    isLoggedIn.value = true;

    await _storage.setBool(AppConstants.keyIsLoggedIn, true);
    await _storage.setString(AppConstants.keyAuthToken, token);
    await _storage.setString(
        AppConstants.keyUserData, jsonEncode(user.toJson()));
  }

  /// Updates the locally cached user model (e.g., after profile edit).
  Future<void> updateUser(UserModel user) async {
    currentUser.value = user;
    await _storage.setString(
        AppConstants.keyUserData, jsonEncode(user.toJson()));
  }

  /// Clears all session data on logout.
  Future<void> clearSession() async {
    currentUser.value = null;
    authToken.value = '';
    isLoggedIn.value = false;

    await _storage.remove(AppConstants.keyIsLoggedIn);
    await _storage.remove(AppConstants.keyAuthToken);
    await _storage.remove(AppConstants.keyUserData);
    await _storage.remove(AppConstants.keyCartData);
  }
}
