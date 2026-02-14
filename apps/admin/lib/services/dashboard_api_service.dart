import '../core/api_client.dart';
import '../features/dashboard/models/dashboard_stats_model.dart';

class DashboardApiService {
  // ignore: unused_field
  final ApiClient _apiClient;

  DashboardApiService(this._apiClient);

  Future<DashboardStats> getStats() async {
    try {
      // For now, we'll use mock data since the backend doesn't have a stats endpoint yet
      // TODO: Replace with actual API call when backend endpoint is ready
      // final response = await _apiClient.get('/admin/stats');
      // return DashboardStats.fromJson(response.data);

      await Future.delayed(const Duration(seconds: 1));
      return DashboardStats(
        totalOrders: 156,
        totalRevenue: 45230.0,
        activeCooks: 12,
        activeCouriers: 8,
        pendingApprovals: 3,
      );
    } catch (e) {
      throw Exception('Failed to load dashboard stats: $e');
    }
  }
}
