import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/services/mock_data_service.dart';

class CookCard extends StatelessWidget {
  final Map<String, dynamic> cook;
  final VoidCallback onTap;

  const CookCard({super.key, required this.cook, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Find a featured dish for the cover image
    final dishes = MockDataService.getDishesByCook(cook['id'] as int);
    final coverImage = dishes.isNotEmpty
        ? dishes.first['image'] as String
        : 'couscous_royal.png'; // Fallback

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3E5224).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Column(
            children: [
              // HERO IMAGE SECTION
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Cover Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: coverImage.startsWith('http')
                          ? Image.network(
                              coverImage,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildPlaceholder(),
                            )
                          : Image.asset(
                              'assets/images/dishes/$coverImage',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildPlaceholder(),
                            ),
                    ),
                  ),
                  // Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Floating Avatar
                  Positioned(
                    bottom: -32,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4EFE6),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            cook['avatar'] ?? '👩‍🍳',
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Rating Badge (Top Left)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Color(0xFFFFB74D),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${cook['rating']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFC15B20),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // INFO SECTION
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cook['name'] ?? 'Cuisinier',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: const Color(0xFF2D3436),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cook['specialty'] ?? 'Cuisine Algérienne',
                      style: TextStyle(
                        color: const Color(0xFF3E5224).withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Badges
                    Row(
                      children: [
                        _buildBadge(
                          context,
                          Icons.location_on_outlined,
                          cook['location'] ?? 'Alger',
                        ),
                        const SizedBox(width: 12),
                        _buildBadge(
                          context,
                          Icons.ramen_dining_outlined,
                          '${cook['dishCount']} plats',
                        ),
                        const Spacer(),
                        Text(
                          'Voir le menu',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0, duration: 500.ms);
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFF4EFE6),
      child: const Center(
        child: Icon(Icons.restaurant, color: Color(0xFFD7CCC8), size: 48),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
