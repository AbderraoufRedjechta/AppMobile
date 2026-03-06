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
    
    // Attempt to get a cover image from dishes
    String? rawImage = _dishes.isNotEmpty ? _dishes.first['image']?.toString() : null;
    String coverImage = rawImage ?? 'couscous_royal.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. Cover Image Header
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                   coverImage.startsWith('http')
                        ? Image.network(coverImage, fit: BoxFit.cover, width: double.infinity)
                        : Image.asset(
                            'assets/images/dishes/$coverImage',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
                          ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 2. Profile Info (Overlapping Avatar Jahez-style)
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // White background container
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cook['name'] ?? 'Cuisinier Local',
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cook['specialty'] ?? 'Plats Faits Maison',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Rating Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Color(0xFFE9B949), size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '${cook['rating'] ?? 4.8}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      Text(
                        'À propos du Chef',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cook['bio'] ??
                            'Passionné de cuisine, je prépare des plats authentiques avec des ingrédients frais et locaux pour vous offrir le meilleur du fait maison.',
                        style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.4),
                      ),
                      
                      const SizedBox(height: 32),
                      const Text(
                        'Spécialités Maison',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                
                // Overlapping Avatar
                Positioned(
                  top: -45,
                  left: 16,
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        cook['avatar'] ?? '👩‍🍳',
                        style: const TextStyle(fontSize: 45),
                      ),
                    ),
                  ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
                ),
              ],
            ),
          ),
          
          // 3. Dishes Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: _isLoading
                ? const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
                : _dishes.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              "Le cuisinier n'a pas encore ajouté de spécialités.",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final dish = _dishes[index];
                            return BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, state) {
                                final isFav = state.isFavorite(dish['id'] as int);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: DishCard(
                                    dish: dish,
                                    isFavorite: isFav,
                                    onFavoriteToggle: () {
                                      context.read<FavoritesCubit>().toggleFavorite(dish['id'] as int);
                                    },
                                    onTap: () => context.push('/dish/${dish['id']}', extra: dish),
                                    onAddToCart: () {
                                      context.read<CartCubit>().addToCart(dish);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${dish['name'] ?? 'Plat'} ajouté au panier'),
                                          backgroundColor: const Color(0xFF933D41), // Wajabat Primary
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          action: SnackBarAction(
                                            label: 'Voir',
                                            textColor: Colors.white,
                                            onPressed: () => context.push('/cart'),
                                          ),
                                        ),
                                      );
                                    },
                                  ).animate(delay: (50 * index).ms).fadeIn().slideY(begin: 0.1, end: 0),
                                );
                              },
                            );
                          },
                          childCount: _dishes.length,
                        ),
                      ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
