import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/dashboard_stats_model.dart';
import '../../../services/dashboard_api_service.dart';

// State
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardStats stats;

  const DashboardLoaded(this.stats);

  @override
  List<Object> get props => [stats];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class DashboardCubit extends Cubit<DashboardState> {
  final DashboardApiService _apiService;

  DashboardCubit(this._apiService) : super(DashboardInitial());

  void loadStats() async {
    emit(DashboardLoading());
    try {
      final stats = await _apiService.getStats();
      emit(DashboardLoaded(stats));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
