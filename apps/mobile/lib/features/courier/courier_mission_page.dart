import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../client/orders_api_service.dart';

class CourierMissionPage extends StatefulWidget {
  const CourierMissionPage({super.key});

  @override
  State<CourierMissionPage> createState() => _CourierMissionPageState();
}

class _CourierMissionPageState extends State<CourierMissionPage> {
  final OrdersApiService _ordersApiService = OrdersApiService(ApiClient());
  List<dynamic> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final orders = await _ordersApiService.getOrders();
      if (mounted) {
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updateStatus(String orderId, String status) async {
    try {
      await _ordersApiService.updateOrderStatus(orderId, status);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Statut mis à jour: $status')),
        );
        _fetchOrders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Missions Livreur')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                final status = order['status'];
                final isDelivered = status == 'DELIVERED';

                return Card(
                  margin: const EdgeInsets.all(8),
                  color: isDelivered ? Colors.green[50] : Colors.white,
                  child: ListTile(
                    title: Text('Commande #${order['id']}'),
                    subtitle: Text('Total: ${order['totalAmount'] ?? order['total'] ?? 0} DA - $status'),
                    trailing: isDelivered
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : ElevatedButton(
                            onPressed: () =>
                                _updateStatus(order['id'].toString(), 'DELIVERED'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Livrer & Encaisser'),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
