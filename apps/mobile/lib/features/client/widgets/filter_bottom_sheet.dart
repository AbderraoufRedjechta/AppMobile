import 'package:flutter/material.dart';

enum SortOption { priceAsc, priceDesc, nameAsc, stock }

class FilterBottomSheet extends StatefulWidget {
  final SortOption currentSort;
  final int? maxPrice;
  final bool showOnlyAvailable;
  final Function(SortOption, int?, bool) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentSort,
    this.maxPrice,
    required this.showOnlyAvailable,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SortOption _selectedSort;
  late int? _maxPrice;
  late bool _showOnlyAvailable;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
    _maxPrice = widget.maxPrice;
    _showOnlyAvailable = widget.showOnlyAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtres et tri',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Tri
          const Text(
            'Trier par',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildSortOption(
            SortOption.priceAsc,
            'Prix croissant',
            Icons.arrow_upward,
          ),
          _buildSortOption(
            SortOption.priceDesc,
            'Prix décroissant',
            Icons.arrow_downward,
          ),
          _buildSortOption(
            SortOption.nameAsc,
            'Nom (A-Z)',
            Icons.sort_by_alpha,
          ),
          _buildSortOption(SortOption.stock, 'Disponibilité', Icons.inventory),
          const Divider(height: 32),
          // Prix maximum
          const Text(
            'Prix maximum',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Slider(
            value: (_maxPrice ?? 1000).toDouble(),
            min: 0,
            max: 1000,
            divisions: 20,
            label: _maxPrice == null ? 'Tous' : '$_maxPrice DA',
            activeColor: const Color(0xFFFF8C00),
            onChanged: (value) {
              setState(() {
                _maxPrice = value.toInt();
              });
            },
          ),
          Text(
            _maxPrice == null ? 'Tous les prix' : 'Jusqu\'à $_maxPrice DA',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const Divider(height: 32),
          // Disponibilité
          CheckboxListTile(
            title: const Text('Afficher uniquement les plats disponibles'),
            value: _showOnlyAvailable,
            activeColor: const Color(0xFFFF8C00),
            onChanged: (value) {
              setState(() {
                _showOnlyAvailable = value ?? false;
              });
            },
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          // Boutons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedSort = SortOption.priceAsc;
                      _maxPrice = null;
                      _showOnlyAvailable = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Réinitialiser'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(
                      _selectedSort,
                      _maxPrice,
                      _showOnlyAvailable,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Appliquer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(SortOption option, String label, IconData icon) {
    final isSelected = _selectedSort == option;
    return RadioListTile<SortOption>(
      title: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected ? const Color(0xFFFF8C00) : Colors.grey,
          ),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
      value: option,
      groupValue: _selectedSort,
      activeColor: const Color(0xFFFF8C00),
      onChanged: (value) {
        setState(() {
          _selectedSort = value!;
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }
}
