import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_cubit.dart';
import 'favorites_cubit.dart';
import 'widgets/dish_card.dart';

import '../../core/api_client.dart';
import 'dishes_api_service.dart';

class CookProfilePage extends StatefulWidget {
  final Map<String, dynamic> cook;

  const CookProfilePage({super.key, required this.cook});

  @override
  State<CookProfilePage> createState() => _CookProfilePageState();
}

class _CookProfilePageState extends State<CookProfilePage> {
  final DishesApiService _dishesApiService = DishesApiService(ApiClient());
  List<Map<String, dynamic>> _dishes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDishes();
  }

  Future<void> _loadDishes() async {
    try {
      final dishes = await _dishesApiService.getDishesByCook(widget.cook['id'] as int);
      if (mounted) {
        setState(() {
          _dishes = dishes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cook = widget.cook;
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
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_dishes.isEmpty)
                    const Center(child: Text("Aucun plat pour l'instant."))
                  else
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
                          itemCount: _dishes.length,
                          itemBuilder: (context, index) {
                            final dish = _dishes[index];
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
