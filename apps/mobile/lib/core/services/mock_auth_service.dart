import '../../features/auth/auth_cubit.dart';

class User {
  final String id;
  final String name;
  final String? avatar;
  final String? phone;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    this.avatar,
    this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'role': role.name,
    };
  }
}

class MockAuthService {
  // Simulate network delay
  Future<void> _delay() async =>
      await Future.delayed(const Duration(seconds: 1));

  Future<void> sendOtp(String phoneNumber) async {
    await _delay();
    // In a real app, this would trigger an SMS
    // For mock, we just accept any valid phone number
    if (!RegExp(r'^0[567][0-9]{8}$').hasMatch(phoneNumber)) {
      throw Exception('Numéro de téléphone invalide');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
    String phoneNumber,
    String otp,
    UserRole requestedRole,
  ) async {
    await _delay();

    if (otp != '123456') {
      throw Exception('Code OTP invalide');
    }

    // Return rich user profile based on role
    return _getMockUserProfile(requestedRole, phoneNumber);
  }

  Map<String, dynamic> _getMockUserProfile(UserRole role, String phone) {
    switch (role) {
      case UserRole.cook:
        return {
          'id': 'cook_1',
          'name': 'Fatima Benali',
          'avatar': '👩‍🍳',
          'phone': phone,
          'role': 'cook',
          'token': 'mock_token_cook',
        };
      case UserRole.courier:
        return {
          'id': 'courier_1',
          'name': 'Mohamed Benali',
          'avatar': '🛵',
          'phone': phone,
          'role': 'courier',
          'token': 'mock_token_courier',
        };
      case UserRole.admin:
        return {
          'id': 'admin_1',
          'name': 'Admin Gusto',
          'phone': phone,
          'role': 'admin',
          'token': 'mock_token_admin',
        };
      case UserRole.client:
      default:
        return {
          'id': 'client_1',
          'name': 'Amine Amari',
          'avatar': '👤',
          'phone': phone,
          'role': 'client',
          'token': 'mock_token_client',
        };
    }
  }
}
