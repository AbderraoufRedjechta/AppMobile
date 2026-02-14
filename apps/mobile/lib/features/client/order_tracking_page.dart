import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class OrderTrackingPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderTrackingPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final status = order['status'] as String;
    final createdAt = DateTime.parse(order['createdAt'] as String);

    // Mock locations for demo
    final courierLocation = LatLng(36.7525, 3.0420); // Algiers
    final destinationLocation = LatLng(36.7528, 3.0425); // Nearby

    return Scaffold(
      appBar: AppBar(
        title: Text('Commande #${order['id']}'),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Map Section (only visible when delivering)
          if (['DELIVERING', 'DELIVERED'].contains(status))
            SizedBox(
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: courierLocation,
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.gusto.app',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [courierLocation, destinationLocation],
                        strokeWidth: 4.0,
                        color: const Color(0xFFFF8C00),
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: courierLocation,
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: const Icon(
                            Icons.delivery_dining,
                            color: Color(0xFFFF8C00),
                            size: 24,
                          ),
                        ),
                      ),
                      Marker(
                        point: destinationLocation,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // En-tête avec statut
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8C00),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _getStatusIcon(status),
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getStatusText(status),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getStatusDescription(status),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Timeline
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Suivi de commande',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildTimelineItem(
                          context,
                          icon: Icons.check_circle,
                          title: 'Commande confirmée',
                          time: createdAt,
                          isCompleted: true,
                          isLast: false,
                        ),
                        _buildTimelineItem(
                          context,
                          icon: Icons.restaurant,
                          title: 'En préparation',
                          time: status == 'PENDING'
                              ? null
                              : createdAt.add(const Duration(minutes: 5)),
                          isCompleted: [
                            'PREPARING',
                            'DELIVERING',
                            'DELIVERED',
                          ].contains(status),
                          isLast: false,
                        ),
                        _buildTimelineItem(
                          context,
                          icon: Icons.delivery_dining,
                          title: 'En livraison',
                          time: status == 'DELIVERING' || status == 'DELIVERED'
                              ? createdAt.add(const Duration(minutes: 30))
                              : null,
                          isCompleted: [
                            'DELIVERING',
                            'DELIVERED',
                          ].contains(status),
                          isLast: false,
                        ),
                        _buildTimelineItem(
                          context,
                          icon: Icons.home,
                          title: 'Livrée',
                          time: status == 'DELIVERED'
                              ? createdAt.add(const Duration(minutes: 45))
                              : null,
                          isCompleted: status == 'DELIVERED',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Détails de la commande
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Détails de la commande',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          Icons.receipt,
                          'Numéro',
                          '#${order['id']}',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          Icons.shopping_bag,
                          'Articles',
                          '${(order['items'] as List).length} plat(s)',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          Icons.access_time,
                          'Date',
                          '${createdAt.day}/${createdAt.month}/${createdAt.year} à ${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}',
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${order['total']} DA',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF8C00),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Boutons d'action
                  // Boutons d'action
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Dynamic Contact Button (Primary)
                        if (['DELIVERING', 'DELIVERED'].contains(status))
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push(
                                  '/chat/${order['id']}',
                                  extra: {
                                    'order': order,
                                    'targetRole': 'courier',
                                    'targetName': 'Livreur',
                                  },
                                );
                              },
                              icon: const Icon(Icons.chat_bubble_outline),
                              label: const Text('Contacter le livreur'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8C00),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push(
                                  '/chat/${order['id']}',
                                  extra: {
                                    'order': order,
                                    'targetRole': 'cook',
                                    'targetName': order['cookName'],
                                  },
                                );
                              },
                              icon: const Icon(Icons.restaurant),
                              label: const Text('Contacter le cuisinier'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8C00),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(height: 12),

                        // Secondary Action (if applicable)
                        if (['DELIVERING', 'DELIVERED'].contains(status))
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                context.push(
                                  '/chat/${order['id']}',
                                  extra: {
                                    'order': order,
                                    'targetRole': 'cook',
                                    'targetName': order['cookName'],
                                  },
                                );
                              },
                              icon: const Icon(Icons.restaurant),
                              label: const Text('Contacter le cuisinier'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        if (status == 'DELIVERED') ...[
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push(
                                  '/rate-order/${order['id']}',
                                  extra: order,
                                );
                              },
                              icon: const Icon(Icons.star),
                              label: const Text('Noter cette commande'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8C00),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required DateTime? time,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFFFF8C00) : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.grey[600],
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: isCompleted ? const Color(0xFFFF8C00) : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isCompleted
                      ? Theme.of(context).textTheme.bodyLarge?.color
                      : Colors.grey[600],
                ),
              ),
              if (time != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
              if (!isLast) const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'PENDING':
        return Icons.schedule;
      case 'PREPARING':
        return Icons.restaurant;
      case 'DELIVERING':
        return Icons.delivery_dining;
      case 'DELIVERED':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'PENDING':
        return 'En attente';
      case 'PREPARING':
        return 'En préparation';
      case 'DELIVERING':
        return 'En livraison';
      case 'DELIVERED':
        return 'Livrée';
      default:
        return status;
    }
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'PENDING':
        return 'Votre commande a été confirmée et sera bientôt préparée';
      case 'PREPARING':
        return 'Le cuisinier prépare votre commande avec soin';
      case 'DELIVERING':
        return 'Votre commande est en route vers vous';
      case 'DELIVERED':
        return 'Votre commande a été livrée. Bon appétit!';
      default:
        return '';
    }
  }
}
