import 'package:equatable/equatable.dart';

enum UserRole { client, cook, courier, admin }

enum UserStatus { pending, approved, rejected }

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final UserStatus status;
  final DateTime joinedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    UserStatus? status,
    DateTime? joinedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] as String,
      email: json['email'] as String,
      role: _parseRole(json['role'] as String),
      status: _parseStatus(json['status'] as String),
      joinedAt: DateTime.now(), // Backend doesn't have this field yet
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name.toUpperCase(),
      'status': status.name.toUpperCase(),
    };
  }

  static UserRole _parseRole(String role) {
    switch (role.toUpperCase()) {
      case 'CLIENT':
        return UserRole.client;
      case 'COOK':
        return UserRole.cook;
      case 'COURIER':
        return UserRole.courier;
      case 'ADMIN':
        return UserRole.admin;
      default:
        return UserRole.client;
    }
  }

  static UserStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return UserStatus.pending;
      case 'APPROVED':
        return UserStatus.approved;
      case 'REJECTED':
        return UserStatus.rejected;
      default:
        return UserStatus.pending;
    }
  }

  @override
  List<Object?> get props => [id, name, email, role, status, joinedAt];
}
