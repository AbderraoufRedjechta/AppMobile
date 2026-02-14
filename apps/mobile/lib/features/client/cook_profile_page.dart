import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_cubit.dart';
import 'favorites_cubit.dart';
import 'widgets/dish_card.dart';

class CookProfilePage extends StatelessWidget {
  final Map<String, dynamic> cook;

  const CookProfilePage({super.key, required this.cook});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final dishes = List.generate(
      4,
      (index) => {
        'id': index + 100,
        'name': 'Plat Spécial ${index + 1}',
        'description': 'Délicieux plat fait maison avec amour.',
        'price': 800 + (index * 100),
        'image': 'couscous_royal.png', // Placeholder
        'stock': 5,
        'cookId': cook['id'],
      },
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/dishes/couscous_royal.png', // Cover image
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(Icons.person, size: 40),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cook['name'] ?? 'Cuisinier',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${cook['rating'] ?? 4.8} (120 avis)',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideX(),
                  const SizedBox(height: 24),
                  const Text(
                    'À propos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cook['bio'] ??
                        'Passionné de cuisine traditionnelle algérienne. Je prépare des plats authentiques avec des ingrédients frais et locaux.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  0.6, // Adjusted to prevent overflow
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: dishes.length,
                        itemBuilder: (context, index) {
                          final dish = dishes[index];
                          final isFavorite = state.isFavorite(
                            dish['id'] as int,
                          );

                          return DishCard(
                            dish: dish,
                            isFavorite: isFavorite,
                            onFavoriteToggle: () {
                              context.read<FavoritesCubit>().toggleFavorite(
                                dish['id'] as int,
                              );
                            },
                            onTap: () => context.push(
                              '/dish/${dish['id']}',
                              extra: dish,
                            ),
                            onAddToCart: () {
                              context.read<CartCubit>().addToCart(dish);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${dish['name']} ajouté au panier',
                                  ),
                                  backgroundColor: const Color(0xFFFF8C00),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Voir',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      context.go('/cart');
                                    },
                                  ),
                                ),
                              );
                            },
                          ).animate(delay: (100 * index).ms).fadeIn().slideY();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
