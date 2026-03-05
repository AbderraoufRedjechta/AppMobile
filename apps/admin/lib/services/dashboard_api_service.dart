import '../core/api_client.dart';
import '../features/dashboard/models/dashboard_stats_model.dart';

class DashboardApiService {
  // ignore: unused_field
  final ApiClient _apiClient;

  DashboardApiService(this._apiClient);

  Future<DashboardStats> getStats() async {
    try {
      final response = await _apiClient.get('/admin/stats');
      return DashboardStats.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load dashboard stats: $e');
    }
  }
}
