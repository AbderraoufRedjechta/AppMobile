import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/wajabat_theme.dart';
import '../../core/services/mock_data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../client/favorites_cubit.dart';
import '../../core/api_client.dart';
import '../client/dishes_api_service.dart';

class WajabatFeed extends StatefulWidget {
  const WajabatFeed({super.key});

  @override
  State<WajabatFeed> createState() => _WajabatFeedState();
}

class _WajabatFeedState extends State<WajabatFeed> {
  final ScrollController _scrollController = ScrollController();
  final DishesApiService _dishesApiService = DishesApiService(ApiClient());
  
  List<Map<String, dynamic>> _cooks = [];
  List<Map<String, dynamic>> _allDishes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final cooks = await _dishesApiService.getCooks();
      final dishes = await _dishesApiService.getDishes();
      if (mounted) {
        setState(() {
          _cooks = cooks;
          _allDishes = dishes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WajabatTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Livraison à',
              style: WajabatTheme.textTheme.bodyMedium?.copyWith(
                color: WajabatTheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                Text(
                  'Alger Centre',
                  style: WajabatTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: WajabatTheme.textDark),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_mall_outlined, color: WajabatTheme.textDark),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      body: _isLoading 
        ? _buildLoader()
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 1. Search Bar Area
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un plat, un cuisinier...',
                      hintStyle: WajabatTheme.textTheme.bodyMedium,
                      prefixIcon: const Icon(Icons.search, color: WajabatTheme.textLight),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: WajabatTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.tune, color: Colors.white, size: 20),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: WajabatTheme.inputFill,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    ),
                  ),
                ),
              ),

              // 2. Promotional Banners (Carousel)
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: index == 0 ? WajabatTheme.primary : WajabatTheme.secondary,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/dishes/couscous_royal.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                index == 0 ? 'Offre Spéciale\n-50% sur le Couscous' : 'Livraison\nGratuite',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 3. Grid Categories (Circular icons, Jahez Style)
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircularCategory(Icons.soup_kitchen, 'Traditionnel', WajabatTheme.primary),
                      _buildCircularCategory(Icons.cake, 'Gâteaux', WajabatTheme.secondary),
                      _buildCircularCategory(Icons.eco, 'Healthy', WajabatTheme.success),
                      _buildCircularCategory(Icons.celebration, 'Évènements', Colors.brown),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // 4. Section Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nos Cuisiniers Locaux',
                        style: WajabatTheme.textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                      Text(
                        'Voir tout',
                        style: TextStyle(color: WajabatTheme.primary, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),

              // 5. Cook Cards (Jahez layout)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final cook = _cooks[index];
                  return _buildJahezCard(cook, index);
                }, childCount: _cooks.length),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 100)), // Bottom padding
            ],
          ),
    );
  }

  Widget _buildCircularCategory(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: WajabatTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: WajabatTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildJahezCard(Map<String, dynamic> cook, int index) {
    String coverImage = 'couscous_royal.png';
    final dishes = _allDishes.where((d) => d['cook'] != null && d['cook']['id'] == cook['id']).toList();
    if (dishes.isNotEmpty) {
      coverImage = dishes.first['image'] ?? 'couscous_royal.png';
    }

    return GestureDetector(
      onTap: () => context.push('/cook/${cook['id']}', extra: cook),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: WajabatTheme.shadowSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: coverImage.startsWith('http')
                        ? Image.network(coverImage, fit: BoxFit.cover, width: double.infinity)
                        : Image.asset(
                            'assets/images/dishes/$coverImage',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                          ),
                  ),
                ),
                
                // Favorite Button (Top right)
                Positioned(
                  top: 12,
                  right: 12,
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      final isFav = state.isFavoriteCook(cook['id'] as int);
                      return GestureDetector(
                        onTap: () {
                          context.read<FavoritesCubit>().toggleFavoriteCook(cook['id'] as int);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? WajabatTheme.primary : Colors.grey,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Overlapping Logo (Bottom left corner of image)
                Positioned(
                  bottom: -20,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 16, color: WajabatTheme.secondary),
                        const SizedBox(width: 4),
                        Text(
                          '${cook['rating']}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          ' (120+)',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Overlapping Avatar (Bottom right corner)
                Positioned(
                  bottom: -16,
                  left: 16,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        cook['avatar'] ?? '👩‍🍳',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Content Info
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cook['name'] ?? 'Cuisinier Local',
                    style: WajabatTheme.textTheme.titleLarge?.copyWith(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cook['specialty'] ?? 'Spécialités Maison',
                    style: WajabatTheme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: WajabatTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.motorcycle, size: 14, color: WajabatTheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              '250 DA', 
                              style: TextStyle(
                                color: WajabatTheme.primary, 
                                fontSize: 12, 
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.schedule, size: 16, color: WajabatTheme.textLight),
                      const SizedBox(width: 4),
                      Text('Précommande 24h', style: WajabatTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: WajabatTheme.secondary,
                        fontWeight: FontWeight.bold,
                      )),
                      const Spacer(),
                      const Icon(Icons.location_on, size: 16, color: WajabatTheme.textLight),
                      const SizedBox(width: 2),
                      Text('2.5 km', style: WajabatTheme.textTheme.bodyMedium?.copyWith(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0, delay: (50 * index).ms);
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(color: WajabatTheme.primary),
    );
  }
}
