import 'package:grocery_app/core/errors/exceptions.dart';
import 'package:grocery_app/core/services/auth_service.dart';
import 'package:grocery_app/data/datasource/mock_data.dart';
import 'package:grocery_app/data/models/user_model.dart';

/// Handles authentication operations — login, signup, password reset.
/// Uses mock data in place of a real API.
class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  /// Simulates a login with email/password.
  /// Returns the authenticated [UserModel] on success.
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Validate against demo credentials
    if (email.trim().toLowerCase() == MockData.demoUser.email.toLowerCase() &&
        password == 'demo1234') {
      const token = 'mock_auth_token_abc123';
      await _authService.saveSession(MockData.demoUser, token);
      return MockData.demoUser;
    }

    throw const AuthException(
      message: 'Invalid email or password. Use demo@grocerygo.com / demo1234',
      code: 'INVALID_CREDENTIALS',
    );
  }

  /// Simulates account creation.
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    // In production this would POST to the API.
    final user = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: email.trim().toLowerCase(),
      createdAt: DateTime.now(),
    );

    const token = 'mock_auth_token_new_user';
    await _authService.saveSession(user, token);
    return user;
  }

  /// Simulates sending a password reset email.
  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(const Duration(seconds: 1));
    // In production: POST /auth/forgot-password
    // For mock, always succeeds.
  }

  /// Logs out the current user.
  Future<void> logout() async {
    await _authService.clearSession();
  }

  /// Updates the user profile.
  Future<UserModel> updateProfile({
    required String name,
    String? phone,
    String? avatarUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final currentUser = _authService.currentUser.value;
    if (currentUser == null) throw const AuthException();

    final updated = currentUser.copyWith(
      name: name,
      phone: phone,
      avatarUrl: avatarUrl,
    );
    await _authService.updateUser(updated);
    return updated;
  }
}
