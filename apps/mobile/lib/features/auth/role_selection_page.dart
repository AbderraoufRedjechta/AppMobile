import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_cubit.dart';
import '../../core/theme/wajabat_theme.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WajabatTheme.background, // Force Wajabat background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Bienvenue sur Wajabat',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: WajabatTheme.textDark,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Choisissez comment vous souhaitez utiliser l\'application',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: WajabatTheme.textLight,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: Column(
                  children: [
                    _buildRoleCard(
                      context,
                      role: UserRole.client,
                      title: 'Je veux commander',
                      subtitle: 'Découvrez des plats faits maison',
                      icon: Icons.restaurant_menu,
                      color: WajabatTheme.primary, // Wajabat Rouge Terre
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      context,
                      role: UserRole.cook,
                      title: 'Je suis Cuisinier',
                      subtitle: 'Vendez vos plats et gérez votre menu',
                      icon: Icons.kitchen,
                      color: WajabatTheme.secondary, // Wajabat Jaune Safran
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      context,
                      role: UserRole.courier,
                      title: 'Je suis Livreur',
                      subtitle: 'Livrez des commandes et gagnez de l\'argent',
                      icon: Icons.delivery_dining,
                      color: const Color(0xFF22C55E), // Wajabat Success Green
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required UserRole role,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        // Navigate to login page with selected role
        String roleParam;
        switch (role) {
          case UserRole.client:
            roleParam = 'client';
            break;
          case UserRole.cook:
            roleParam = 'cook';
            break;
          case UserRole.courier:
            roleParam = 'courier';
            break;
          default:
            roleParam = 'client';
        }
        context.go('/login/$roleParam');
      },
      borderRadius: BorderRadius.circular(24), // Premium rounded
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.transparent),
          boxShadow: WajabatTheme.shadowSmall, // Jahez subtle shadow
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      color: WajabatTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: WajabatTheme.textLight,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[300], size: 28),
          ],
        ),
      ),
    );
  }
}
