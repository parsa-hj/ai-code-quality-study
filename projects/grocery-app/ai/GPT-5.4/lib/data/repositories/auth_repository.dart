class AuthRepository {
  Future<void> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
  }

  Future<void> resetPassword(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
  }
}
