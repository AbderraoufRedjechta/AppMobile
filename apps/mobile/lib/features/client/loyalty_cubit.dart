import 'package:flutter_bloc/flutter_bloc.dart';

class LoyaltyCubit extends Cubit<LoyaltyState> {
  LoyaltyCubit() : super(LoyaltyState(points: 1250, tier: 'Silver'));

  void addPoints(int points) {
    final newPoints = state.points + points;
    final newTier = _calculateTier(newPoints);

    emit(state.copyWith(points: newPoints, tier: newTier));
  }

  void redeemPoints(int points) {
    if (points <= state.points) {
      emit(state.copyWith(points: state.points - points));
    }
  }

  int calculatePointsFromOrder(double total) {
    // 1 point for every 100 DA
    return (total / 100).floor();
  }

  String _calculateTier(int points) {
    if (points >= 5000) return 'Gold';
    if (points >= 2000) return 'Silver';
    return 'Bronze';
  }

  int getPointsToNextTier() {
    if (state.tier == 'Bronze') {
      return 2000 - state.points;
    } else if (state.tier == 'Silver') {
      return 5000 - state.points;
    }
    return 0; // Already at Gold
  }
}

class LoyaltyState {
  final int points;
  final String tier;

  LoyaltyState({required this.points, required this.tier});

  LoyaltyState copyWith({int? points, String? tier}) {
    return LoyaltyState(points: points ?? this.points, tier: tier ?? this.tier);
  }
}
