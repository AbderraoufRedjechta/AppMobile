import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'cart_cubit.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _currentStep = 0;
  String _selectedAddress = 'Maison (123 Rue Didouche Mourad)';
  String _selectedTime = 'Dès que possible (30-45 min)';
  String _selectedPayment = 'Espèces à la livraison (COD)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commander'),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            _processOrder();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'Confirmer la commande' : 'Suivant',
                    ),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text(
                      'Retour',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Livraison'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Adresse de livraison'),
                _buildOptionTile(
                  title: 'Maison',
                  subtitle: '123 Rue Didouche Mourad, Alger',
                  value: 'Maison (123 Rue Didouche Mourad)',
                  groupValue: _selectedAddress,
                  onChanged: (val) => setState(() => _selectedAddress = val!),
                ),
                _buildOptionTile(
                  title: 'Bureau',
                  subtitle: 'Sidi Abdellah, Alger',
                  value: 'Bureau (Sidi Abdellah)',
                  groupValue: _selectedAddress,
                  onChanged: (val) => setState(() => _selectedAddress = val!),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.push('/addresses');
                  },
                  icon: const Icon(Icons.add, color: Color(0xFFFF8C00)),
                  label: const Text(
                    'Ajouter une adresse',
                    style: TextStyle(color: Color(0xFFFF8C00)),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Heure de livraison'),
                _buildOptionTile(
                  title: 'Dès que possible',
                  subtitle: '30-45 min',
                  value: 'Dès que possible (30-45 min)',
                  groupValue: _selectedTime,
                  onChanged: (val) => setState(() => _selectedTime = val!),
                ),
                _buildOptionTile(
                  title: 'Programmer',
                  subtitle: 'Choisir une heure',
                  value: 'Programmer',
                  groupValue: _selectedTime,
                  onChanged: (val) => setState(() => _selectedTime = val!),
                ),
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Paiement'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Mode de paiement'),
                _buildOptionTile(
                  title: 'Espèces à la livraison',
                  subtitle: 'Payer à la réception',
                  value: 'Espèces à la livraison (COD)',
                  groupValue: _selectedPayment,
                  onChanged: (val) => setState(() => _selectedPayment = val!),
                  icon: Icons.money,
                ),
                _buildOptionTile(
                  title: 'Carte Edahabia',
                  subtitle: 'Paiement sécurisé (Bientôt)',
                  value: 'Carte Edahabia',
                  groupValue: _selectedPayment,
                  onChanged: null, // Disabled for now
                  icon: Icons.credit_card,
                ),
              ],
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Résumé'),
            content: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final groupedItems = _groupItemsByDish(state.items);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Récapitulatif'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          ...groupedItems.entries.map((entry) {
                            final dish = entry.value.first;
                            final quantity = entry.value.length;
                            final total = (dish['price'] as int) * quantity;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${quantity}x ${dish['name']}'),
                                  Text('$total DZD'),
                                ],
                              ),
                            );
                          }),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sous-total'),
                              Text('${state.total} DZD'),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('Livraison'), Text('300 DZD')],
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Code Promo',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[200],
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                  ),
                                  child: const Text('Appliquer'),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${state.total + 300} DZD',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFFF8C00),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Adresse', _selectedAddress),
                    _buildInfoRow('Heure', _selectedTime),
                    _buildInfoRow('Paiement', _selectedPayment),
                  ],
                );
              },
            ),
            isActive: _currentStep >= 2,
            state: _currentStep == 2 ? StepState.editing : StepState.complete,
          ),
        ],
      ),
    );
  }

  Map<int, List<Map<String, dynamic>>> _groupItemsByDish(
    List<Map<String, dynamic>> items,
  ) {
    final Map<int, List<Map<String, dynamic>>> grouped = {};
    for (final item in items) {
      final id = item['id'] as int;
      if (!grouped.containsKey(id)) {
        grouped[id] = [];
      }
      grouped[id]!.add(item);
    }
    return grouped;
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required String subtitle,
    required String value,
    required String? groupValue,
    required ValueChanged<String?>? onChanged,
    IconData? icon,
  }) {
    return RadioListTile<String>(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      secondary: icon != null ? Icon(icon, color: Colors.grey[600]) : null,
      activeColor: const Color(0xFFFF8C00),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  void _processOrder() {
    // Simulate order processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context); // Dismiss loading
        final total = context.read<CartCubit>().state.total + 300;
        final items = context.read<CartCubit>().state.items;

        // Create mock order
        final mockOrder = {
          'id':
              'CMD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
          'status': 'PENDING',
          'createdAt': DateTime.now().toIso8601String(),
          'total': total,
          'items': items,
        };

        context.read<CartCubit>().clearCart();
        context.go('/order-success', extra: mockOrder);
      }
    });
  }
}
