import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';
import '../../../services/user_api_service.dart';

// State
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class UserCubit extends Cubit<UserState> {
  final UserApiService _apiService;

  UserCubit(this._apiService) : super(UserInitial());

  void loadUsers() async {
    emit(UserLoading());
    try {
      final users = await _apiService.getAllUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void updateUserStatus(String userId, UserStatus newStatus) async {
    if (state is UserLoaded) {
      try {
        await _apiService.updateUserStatus(userId, newStatus);
        // Reload users after successful update
        loadUsers();
      } catch (e) {
        emit(UserError(e.toString()));
      }
    }
  }
}
