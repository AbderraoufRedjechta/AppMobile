import 'package:wajabat/core/api_client.dart';
import 'package:wajabat/features/auth/auth_cubit.dart' show UserRole;

class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService(this._apiClient);

  Future<void> sendOtp(String phone) async {
    await _apiClient.post('/auth/send-otp', data: {'phone': phone});
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp, UserRole role) async {
    final response = await _apiClient.post(
      '/auth/verify-otp',
      data: {'phone': phone, 'otp': otp},
    );
    // The backend returns an access_token and user info. 
    // We map it to the structure auth_cubit expects (id, name, avatar, phone, token).
    final data = response.data;
    final user = data['user'];
    
    return {
      'id': user['id'].toString(),
      'name': user['name'] ?? 'User ${phone.substring(phone.length - 4)}',
      'avatar': user['avatar'] ?? 'https://i.pravatar.cc/150?u=$phone',
      'phone': phone,
      'token': data['access_token'],
    };
  }
}
