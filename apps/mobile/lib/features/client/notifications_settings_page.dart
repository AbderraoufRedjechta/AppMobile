import 'package:flutter/material.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool _orderUpdates = true;
  bool _promotions = true;
  bool _newArrivals = false;
  bool _appUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Commandes'),
          _buildSwitchTile(
            title: 'Mises à jour des commandes',
            subtitle: 'Statut de préparation et livraison',
            value: _orderUpdates,
            onChanged: (val) => setState(() => _orderUpdates = val),
          ),
          const Divider(),
          _buildSectionHeader('Offres & Actus'),
          _buildSwitchTile(
            title: 'Promotions et réductions',
            subtitle: 'Soyez averti des bons plans',
            value: _promotions,
            onChanged: (val) => setState(() => _promotions = val),
          ),
          _buildSwitchTile(
            title: 'Nouveaux plats',
            subtitle: 'Quand vos cuisiniers préférés publient',
            value: _newArrivals,
            onChanged: (val) => setState(() => _newArrivals = val),
          ),
          const Divider(),
          _buildSectionHeader('Application'),
          _buildSwitchTile(
            title: 'Mises à jour de l\'app',
            subtitle: 'Nouvelles fonctionnalités et correctifs',
            value: _appUpdates,
            onChanged: (val) => setState(() => _appUpdates = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFFF8C00),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      value: value,
      onChanged: onChanged,
      activeThumbColor: const Color(0xFFFF8C00),
    );
  }
}
