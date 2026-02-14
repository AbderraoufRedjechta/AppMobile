import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddressManagementPage extends StatefulWidget {
  const AddressManagementPage({super.key});

  @override
  State<AddressManagementPage> createState() => _AddressManagementPageState();
}

class _AddressManagementPageState extends State<AddressManagementPage> {
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': 1,
      'label': 'Maison',
      'address': '123 Rue Didouche Mourad, Alger',
      'wilaya': 'Alger',
      'commune': 'Alger Centre',
      'isDefault': true,
    },
    {
      'id': 2,
      'label': 'Travail',
      'address': '456 Avenue de l\'Indépendance, Oran',
      'wilaya': 'Oran',
      'commune': 'Oran',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Mes Adresses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
      ),
      body: _addresses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 100, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Aucune adresse enregistrée',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showAddAddressDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter une adresse'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  address['label'] == 'Maison'
                                      ? Icons.home
                                      : address['label'] == 'Travail'
                                      ? Icons.work
                                      : Icons.location_on,
                                  color: const Color(0xFFFF8C00),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  address['label'] as String,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (address['isDefault'] as bool)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFF8C00,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Par défaut',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFF8C00),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          address['address'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${address['commune']}, ${address['wilaya']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (!(address['isDefault'] as bool))
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      for (var addr in _addresses) {
                                        addr['isDefault'] = false;
                                      }
                                      address['isDefault'] = true;
                                    });
                                  },
                                  icon: const Icon(Icons.check, size: 18),
                                  label: const Text('Définir par défaut'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFFFF8C00),
                                    side: const BorderSide(
                                      color: Color(0xFFFF8C00),
                                    ),
                                  ),
                                ),
                              ),
                            if (!(address['isDefault'] as bool))
                              const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _showEditAddressDialog(address);
                                },
                                icon: const Icon(Icons.edit, size: 18),
                                label: const Text('Modifier'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey[700],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () {
                                _showDeleteConfirmation(address);
                              },
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddAddressDialog,
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }

  Future<void> _showAddAddressDialog() async {
    final result = await context.push('/address-picker');
    if (result != null && result is Map<String, dynamic>) {
      if (mounted) {
        _showAddressDetailsDialog(result);
      }
    }
  }

  void _showAddressDetailsDialog(Map<String, dynamic> locationData) {
    final addressController = TextEditingController(
      text: locationData['address'] as String,
    );
    final labelController = TextEditingController();
    final wilayaController = TextEditingController(text: 'Alger');
    final communeController = TextEditingController(text: 'Alger Centre');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Détails de l\'adresse'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration: const InputDecoration(
                  labelText: 'Libellé',
                  hintText: 'Maison, Travail, etc.',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Adresse complète',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: wilayaController,
                decoration: const InputDecoration(labelText: 'Wilaya'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: communeController,
                decoration: const InputDecoration(labelText: 'Commune'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _addresses.add({
                  'id': _addresses.length + 1,
                  'label': labelController.text.isEmpty
                      ? 'Nouvelle adresse'
                      : labelController.text,
                  'address': addressController.text,
                  'wilaya': wilayaController.text,
                  'commune': communeController.text,
                  'isDefault': false,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C00),
              foregroundColor: Colors.white,
            ),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _showEditAddressDialog(Map<String, dynamic> address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier l\'adresse'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Libellé'),
                controller: TextEditingController(
                  text: address['label'] as String,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Adresse complète',
                ),
                controller: TextEditingController(
                  text: address['address'] as String,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Wilaya'),
                controller: TextEditingController(
                  text: address['wilaya'] as String,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Commune'),
                controller: TextEditingController(
                  text: address['commune'] as String,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Update address
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C00),
              foregroundColor: Colors.white,
            ),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'adresse'),
        content: Text(
          'Voulez-vous vraiment supprimer l\'adresse "${address['label']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _addresses.remove(address);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
