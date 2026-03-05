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

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalOrders: json['totalOrders'] as int,
      activeCooks: json['activeCooks'] as int,
      activeCouriers: json['activeCouriers'] as int,
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      pendingApprovals: json['pendingApprovals'] as int,
    );
  }

  @override
  List<Object?> get props => [
        totalOrders,
        activeCooks,
        activeCouriers,
        totalRevenue,
        pendingApprovals,
      ];
}
