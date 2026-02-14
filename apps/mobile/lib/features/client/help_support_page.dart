import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide et Support'),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSectionTitle('Foire Aux Questions'),
          _buildExpansionTile(
            'Comment passer une commande ?',
            'Parcourez le menu, ajoutez des plats à votre panier et suivez les étapes de paiement. C\'est simple et rapide !',
          ),
          _buildExpansionTile(
            'Quels sont les modes de paiement ?',
            'Nous acceptons actuellement le paiement à la livraison (espèces). Le paiement par carte Edahabia sera bientôt disponible.',
          ),
          _buildExpansionTile(
            'Comment suivre ma commande ?',
            'Une fois votre commande validée, vous pouvez suivre son statut en temps réel depuis la section "Mes commandes".',
          ),
          _buildExpansionTile(
            'Puis-je annuler ma commande ?',
            'Vous pouvez annuler votre commande tant qu\'elle n\'a pas été acceptée par le cuisinier. Contactez le support pour toute assistance.',
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Contactez-nous'),
          _buildContactTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: 'support@gusto.dz',
            onTap: () => _launchUrl('mailto:support@gustofood.com'),
          ),
          _buildContactTile(
            icon: Icons.phone,
            title: 'Téléphone',
            subtitle: '+213 550 000 000',
            onTap: () => _launchUrl('tel:+213550000000'),
          ),
          _buildContactTile(
            icon: Icons.chat,
            title: 'WhatsApp',
            subtitle: 'Discuter avec nous',
            onTap: () => _launchUrl('https://wa.me/213550000000'),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(0xFFFF8C00).withOpacity(0.1),
      child: Column(
        children: [
          const Icon(Icons.support_agent, size: 64, color: Color(0xFFFF8C00)),
          const SizedBox(height: 16),
          const Text(
            'Comment pouvons-nous vous aider ?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Notre équipe est là pour répondre à toutes vos questions.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFF8C00),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            content,
            style: TextStyle(color: Colors.grey[700], height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFF8C00).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFFFF8C00)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }
}
