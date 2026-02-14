import '../core/api_client.dart';
import '../features/users/models/user_model.dart';

class UserApiService {
  final ApiClient _apiClient;

  UserApiService(this._apiClient);

  Future<List<User>> getAllUsers() async {
    try {
      final response = await _apiClient.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<User> updateUserStatus(String userId, UserStatus status) async {
    try {
      final response = await _apiClient.patch(
        '/users/$userId/status',
        data: {'status': status.name.toUpperCase()},
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user status: $e');
    }
  }
}
