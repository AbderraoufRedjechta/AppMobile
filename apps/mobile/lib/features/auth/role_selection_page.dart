import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_cubit.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Bienvenue sur Gusto',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choisissez comment vous souhaitez utiliser l\'application',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  color: Colors.grey[600],
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
                      color: const Color(0xFFCC5500), // Burnt Orange
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      context,
                      role: UserRole.cook,
                      title: 'Je suis Cuisinier',
                      subtitle: 'Vendez vos plats et gérez votre menu',
                      icon: Icons.kitchen,
                      color: const Color(0xFF708238), // Olive Green
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      context,
                      role: UserRole.courier,
                      title: 'Je suis Livreur',
                      subtitle: 'Livrez des commandes et gagnez de l\'argent',
                      icon: Icons.delivery_dining,
                      color: const Color(0xFF795548), // Warm Brown
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
