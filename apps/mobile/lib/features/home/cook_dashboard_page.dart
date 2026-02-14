import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CookDashboardPage extends StatelessWidget {
  const CookDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord Cuisinière'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/create-dish'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatCard('Commandes en cours', '3', Colors.orange),
          const SizedBox(height: 16),
          _buildStatCard('Revenus du jour', '4500 DA', Colors.green),
          const SizedBox(height: 24),
          const Text(
            'Dernières commandes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildOrderItem(
            'Commande #123',
            'Couscous Royal x2',
            'En préparation',
          ),
          _buildOrderItem('Commande #124', 'Chakhchoukha x1', 'En attente'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String id, String details, String status) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.receipt_long),
        title: Text(id),
        subtitle: Text(details),
        trailing: Chip(
          label: Text(status),
          backgroundColor: status == 'En préparation'
              ? Colors.orange[100]
              : Colors.grey[200],
        ),
      ),
    );
  }
}
