import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'favorites_cubit.dart';
import 'cart_cubit.dart';
import 'widgets/dish_card.dart';
import '../../core/services/mock_data_service.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _allDishes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDishes();
  }

  Future<void> _fetchDishes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _allDishes = MockDataService.getDishes();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Mes Favoris',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final favoriteDishes = _allDishes
              .where((dish) => favState.isFavorite(dish['id'] as int))
              .toList();

          if (favoriteDishes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun favori pour le moment',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ajoutez des plats à vos favoris\npour les retrouver facilement',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.restaurant_menu),
                    label: const Text('Découvrir les plats'),
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
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favoriteDishes.length,
            itemBuilder: (context, index) {
              final dish = favoriteDishes[index];
              return DishCard(
                dish: dish,
                isFavorite: true,
                onFavoriteToggle: () {
                  context.read<FavoritesCubit>().removeFavorite(
                    dish['id'] as int,
                  );
                },
                onTap: () {
                  context.push('/dish/${dish['id']}', extra: dish);
                },
                onAddToCart: () {
                  context.read<CartCubit>().addToCart(dish);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${dish['name']} ajouté au panier'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: const Color(0xFFFF8C00),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
