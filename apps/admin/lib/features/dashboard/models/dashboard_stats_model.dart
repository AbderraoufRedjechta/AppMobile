import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int totalOrders;
  final int activeCooks;
  final int activeCouriers;
  final double totalRevenue;
  final int pendingApprovals;

  const DashboardStats({
    required this.totalOrders,
    required this.activeCooks,
    required this.activeCouriers,
    required this.totalRevenue,
    required this.pendingApprovals,
  });

  @override
  List<Object?> get props => [
    totalOrders,
    activeCooks,
    activeCouriers,
    totalRevenue,
    pendingApprovals,
  ];
}
