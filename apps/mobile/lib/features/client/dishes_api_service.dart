import 'package:wajabat/core/api_client.dart';

class DishesApiService {
  final ApiClient _apiClient;

  DishesApiService(this._apiClient);

  Future<List<Map<String, dynamic>>> getCooks() async {
    final response = await _apiClient.get('/users/cooks'); 
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getDishes() async {
    final response = await _apiClient.get('/dishes');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getDishById(int id) async {
    final response = await _apiClient.get('/dishes/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getDishesByCook(int cookId) async {
    // Assuming backend /dishes returns all, we filter locally for now,
    // or ideally backend has /dishes?cookId=...
    final dishes = await getDishes();
    return dishes.where((d) => d['cook'] != null && d['cook']['id'] == cookId).toList();
  }

  Future<List<Map<String, dynamic>>> searchDishes(String query) async {
    final dishes = await getDishes();
    final lowerQuery = query.toLowerCase();
    return dishes.where((dish) {
      final name = (dish['name'] as String).toLowerCase();
      final description = (dish['description'] as String).toLowerCase();
      return name.contains(lowerQuery) || description.contains(lowerQuery);
    }).toList();
  }

  Future<List<Map<String, dynamic>>> searchCooks(String query) async {
    final cooks = await getCooks();
    final lowerQuery = query.toLowerCase();
    return cooks.where((cook) {
      final name = (cook['name'] as String).toLowerCase();
      return name.contains(lowerQuery);
    }).toList();
  }
}
