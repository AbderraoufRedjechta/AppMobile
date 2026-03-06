import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../core/api_client.dart';
import 'auth_api_service.dart';

enum UserRole { client, cook, courier, admin }

class User extends Equatable {
  final int id;
  final String name;
  final String? avatar;
  final String phone;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    this.avatar,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      role: UserRole.values.firstWhere((e) => e.name == json['role'], orElse: () => UserRole.client),
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

  @override
  List<Object?> get props => [id, name, avatar, phone, role];
}

class AuthState extends Equatable {
  final bool isAuthenticated;
  final User? user;
  final String? token;

  const AuthState({this.isAuthenticated = false, this.user, this.token});

  // Getter for backward compatibility and ease of use
  UserRole? get role => user?.role;

  AuthState copyWith({bool? isAuthenticated, User? user, String? token}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, user, token];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthApiService _authService;
  final ApiClient _apiClient;

  AuthCubit({required AuthApiService authService, required ApiClient apiClient})
    : _authService = authService,
      _apiClient = apiClient,
      super(const AuthState()) {
    checkSession();
  }

  Future<void> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userJson = prefs.getString('user_data');

    if (token != null && userJson != null) {
      try {
        final user = User.fromJson(jsonDecode(userJson));
        _apiClient.setAuthToken(token);
        emit(AuthState(isAuthenticated: true, user: user, token: token));
      } catch (e) {
        // Corrupt data, clear session
        await logout();
      }
    }
  }

  Future<void> login({
    required String phone,
    required String otp,
    required UserRole role,
  }) async {
    try {
      final data = await _authService.verifyOtp(phone, otp, role);
      final user = User(
        id: data['id'],
        name: data['name'],
        avatar: data['avatar'],
        phone: data['phone'],
        role: role,
      );
      final token = data['token'];

      _apiClient.setAuthToken(token);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_data', jsonEncode(user.toJson()));

      emit(AuthState(isAuthenticated: true, user: user, token: token));
    } catch (e) {
      // Re-throw to be handled by UI
      rethrow;
    }
  }

  Future<void> logout() async {
    _apiClient.clearAuthToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(const AuthState());
  }

  // Helper method to send OTP (proxy to service)
  Future<void> requestOtp(String phone) async {
    await _authService.sendOtp(phone);
  }
}
