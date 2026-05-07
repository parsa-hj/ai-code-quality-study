import '../datasource/mock_grocery_datasource.dart';
import '../models/user_profile_model.dart';

class ProfileRepository {
  ProfileRepository(this._dataSource);

  final MockGroceryDataSource _dataSource;

  Future<UserProfileModel> getProfile() => _dataSource.fetchProfile();
}
