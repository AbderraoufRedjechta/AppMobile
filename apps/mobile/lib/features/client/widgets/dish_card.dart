import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  final Map<String, dynamic> dish;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;

  const DishCard({
    super.key,
    required this.dish,
    required this.onTap,
    required this.onAddToCart,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final stock = dish['stock'] as int;
    final isLowStock = stock < 10;
    final isOutOfStock = stock == 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: isOutOfStock ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: _buildImage(dish['image'] as String?),
                ),
                // Badges et bouton favori
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Bouton favori
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          iconSize: 20,
                          color: isFavorite ? Colors.red : Colors.grey,
                          onPressed: onFavoriteToggle,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      // Badges
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (isOutOfStock)
                            _buildBadge('Épuisé', Colors.red)
                          else if (isLowStock)
                            _buildBadge('Presque épuisé', Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Contenu
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom complet
                  Text(
                    dish['name'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Description
                  Text(
                    dish['description'] as String,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Prix et stock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${dish['price']} DA',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF933D41), // Wajabat Primary
                        ),
                      ),
                      if (isLowStock && !isOutOfStock)
                        Text(
                          'Plus que $stock!',
                          style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Bouton Ajouter - Jahez Style (Pill shape)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isOutOfStock ? null : onAddToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOutOfStock ? Colors.grey[300] : const Color(0xFFF8F4E9), // Blanc Chaud
                        foregroundColor: const Color(0xFF933D41), // Rouge Terre
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        minimumSize: const Size(0, 36),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(isOutOfStock ? Icons.block : Icons.add, size: 18),
                          if (!isOutOfStock) const SizedBox(width: 4),
                          Text(
                            isOutOfStock ? 'Épuisé' : 'Ajouter',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        height: 160,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(
            Icons.fastfood,
            size: 48,
            color: Colors.grey,
          ),
        ),
      );
    }

    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    return Image.asset(
      'assets/images/dishes/$imagePath',
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 160,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(
          Icons.fastfood,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}
