import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/gusto_theme.dart';
import '../../core/services/mock_data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../client/favorites_cubit.dart';

class GustoFeed extends StatefulWidget {
  const GustoFeed({super.key});

  @override
  State<GustoFeed> createState() => _GustoFeedState();
}

class _GustoFeedState extends State<GustoFeed> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _cooks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(1.seconds); // Cinematic load
    if (mounted) {
      setState(() {
        _cooks = MockDataService.getCooks();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GustoTheme.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 1. LIVE MAP HEADER
          _buildLiveHeader(),

          // 2. GREETING SEGMENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mrahba, Karim 👋',
                    style: GustoTheme.textTheme.displayMedium,
                  ).animate().fadeIn().slideX(),
                  const SizedBox(height: 8),
                  Text(
                    'Qu\'est-ce qu\'on mange aujourd\'hui ?',
                    style: GustoTheme.textTheme.bodyLarge?.copyWith(
                      color: GustoTheme.textLight,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                ],
              ),
            ),
          ),

          // 3. CINEMATIC LIST
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 120), // Clearance for Dock
            sliver: _isLoading
                ? SliverToBoxAdapter(child: _buildLoader())
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final cook = _cooks[index];
                      return _buildHeroCard(cook, index);
                    }, childCount: _cooks.length),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveHeader() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 180, // Taller header
      backgroundColor:
          Colors.transparent, // Let content show through or handle below
      elevation: 0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          background: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Brand Gradient Background
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFEF6C00), // Deep Orange
                      Color(0xFFFF9800), // Primary Orange
                    ],
                  ),
                ),
              ),

              // 2. Subtle Abstract Pattern
              Positioned(
                right: -40,
                top: -40,
                child: Transform.rotate(
                  angle: -0.2,
                  child: Icon(
                    Icons.soup_kitchen, // Cooking pot (more "Tayabli")
                    size: 240,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                bottom: -20,
                child: Transform.rotate(
                  angle: 0.2,
                  child: Icon(
                    Icons.dinner_dining, // Plated meal
                    size: 180,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // 3. Content
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo in Premium Container
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 44,
                        width: 44,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.restaurant,
                          color: GustoTheme.primary,
                          size: 30,
                        ),
                      ),
                    ).animate().scale(
                      duration: 800.ms,
                      curve: Curves.elasticOut,
                    ),

                    const SizedBox(height: 12),

                    // Glassmorphic Location Pill
                    ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              color: Colors.white.withOpacity(0.2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Alger Centre',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () => context.push('/cart'),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(Map<String, dynamic> cook, int index) {
    // Determine the cover image logic
    String coverImage = 'couscous_royal.png';
    final dishes = MockDataService.getDishesByCook(cook['id'] as int);
    if (dishes.isNotEmpty) {
      coverImage = dishes.first['image'];
    }

    return GestureDetector(
          onTap: () => context.push('/cook/${cook['id']}', extra: cook),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            height: 320,
            decoration: BoxDecoration(
              borderRadius: GustoTheme.radiusXL,
              color: Colors.white,
              boxShadow: GustoTheme.shadowHero,
            ),
            child: Stack(
              children: [
                // 1. Cover Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: GustoTheme.radiusXL,
                    child: coverImage.startsWith('http')
                        ? Image.network(coverImage, fit: BoxFit.cover)
                        : Image.asset(
                            'assets/images/dishes/$coverImage',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: Colors.grey[300]),
                          ),
                  ),
                ),

                // 2. Gradient
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: GustoTheme.radiusXL,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),

                // 3. Heart Icon (Cook Favorite)
                Positioned(
                  top: 16,
                  right: 16,
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      final isFav = state.isFavoriteCook(cook['id'] as int);
                      return GestureDetector(
                        onTap: () {
                          context.read<FavoritesCubit>().toggleFavoriteCook(
                            cook['id'] as int,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 4. Info
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: GustoTheme.background,
                              child: Text(
                                cook['avatar'] ?? '👩‍🍳',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              cook['name'] ?? 'Chef',
                              style: GustoTheme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: GustoTheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${cook['rating']} ★',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cook['specialty'] ?? 'Specialité Maison',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.1, end: 0, delay: (100 * index).ms);
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(color: GustoTheme.primary),
    );
  }
}
