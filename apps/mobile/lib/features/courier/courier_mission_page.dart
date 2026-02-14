import 'package:flutter/material.dart';
import '../../core/services/mock_data_service.dart';

class CourierMissionPage extends StatefulWidget {
  const CourierMissionPage({super.key});

  @override
  State<CourierMissionPage> createState() => _CourierMissionPageState();
}

class _CourierMissionPageState extends State<CourierMissionPage> {
  List<dynamic> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        // Use mock data from service
        _orders = MockDataService.getOrders();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateStatus(String orderId, String status) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Statut mis à jour: $status (Simulation)')),
      );
      // In a real app, we would refresh the data here
      // For now, just trigger a rebuild/fetch
      _fetchOrders();
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
                    subtitle: Text('Total: ${order['total']} DA - $status'),
                    trailing: isDelivered
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : ElevatedButton(
                            onPressed: () =>
                                _updateStatus(order['id'], 'DELIVERED'),
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
