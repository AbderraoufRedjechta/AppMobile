import 'package:dio/dio.dart';
import '../../core/api_client.dart';

class OrdersApiService {
  final ApiClient _apiClient;

  OrdersApiService(this._apiClient);

  Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      final response = await _apiClient.dio.get('/orders');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data as List);
      }
      return [];
    } on DioException catch (e) {
      throw Exception('Erreur de chargement des commandes: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getOrderById(String id) async {
    try {
      final response = await _apiClient.dio.get('/orders/$id');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception('Commande non trouvée');
    } on DioException catch (e) {
      throw Exception('Erreur réseau: ${e.message}');
    }
  }

  Future<void> updateOrderStatus(String id, String status) async {
    try {
      await _apiClient.dio.post('/orders/$id/status', data: {'status': status});
    } on DioException catch (e) {
      throw Exception('Erreur réseau: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> createOrder({
    required int clientId,
    required int cookId,
    required int dishId,
    required List<int> items,
    required int total,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/orders',
        data: {
          'clientId': clientId,
          'cookId': cookId,
          'dishId': dishId,
          'items': items,
          'total': total,
        },
      );
      if (response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception('Failed to create order');
    } on DioException catch (e) {
      throw Exception('Erreur réseau: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getCookOrders(int cookId) async {
    try {
      final response = await _apiClient.dio.get('/orders/cook/$cookId');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data as List);
      }
      return [];
    } on DioException catch (e) {
      throw Exception('Erreur de chargement des commandes: ${e.message}');
    }
  }
}
