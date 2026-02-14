import '../core/api_client.dart';

class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService(this._apiClient);

  Future<String> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return response.data['access_token'] as String;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
