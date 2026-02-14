import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/services/mock_data_service.dart';
import '../../core/widgets/skeleton_loader.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/theme/design_system.dart';
import 'widgets/cook_card.dart';
import 'widgets/mini_cart_bar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> _cooks = [];
  final List<Map<String, dynamic>> _categories = [
    {'label': 'Tout', 'icon': Icons.grid_view_rounded},
    {'label': 'Plats principaux', 'icon': Icons.restaurant},
    {'label': 'Street Food', 'icon': Icons.fastfood_rounded},
    {'label': 'Soupes', 'icon': Icons.soup_kitchen_rounded},
    {'label': 'Entrées', 'icon': Icons.tapas_rounded},
    {'label': 'Desserts', 'icon': Icons.icecream_rounded},
  ];

  String _selectedCategory = 'Tout';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    final cooks = MockDataService.getCooks();

    if (mounted) {
      setState(() {
        _cooks = cooks;
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredCooks {
    if (_selectedCategory == 'Tout') return _cooks;
    return _cooks.where((cook) {
      final cookDishes = MockDataService.getDishesByCook(cook['id'] as int);
      return cookDishes.any((dish) => dish['category'] == _selectedCategory);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // 1. LIVE MAP HEADER
        SliverAppBar(
          expandedHeight: 120.0,
          floating: false,
          pinned: true,
          backgroundColor: Colors.white.withOpacity(0.9),
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 32,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.restaurant_menu,
                      color: GustoDesign.primary,
                    ),
                  ),
                ],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GustoDesign.background,
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://via.placeholder.com/800x400/E0E0E0/FFFFFF?text=Alger+Centre+Map',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8),
                        BlendMode.lighten,
                      ),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          actions: [
            _buildGlassButton(
              Icons.search_rounded,
              () => context.push('/search'),
            ),
            const SizedBox(width: 8),
            _buildGlassButton(
              Icons.shopping_bag_outlined,
              () => context.push('/cart'),
            ),
            const SizedBox(width: 16),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _buildGlassButton(Icons.menu_rounded, () {}),
          ),
        ),

        // 2. GREETING
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mrahba, Karim ! 👋',
                  style: GustoDesign.textTheme.displayMedium,
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: GustoDesign.secondary.withOpacity(0.1),
                    borderRadius: GustoDesign.radiusSmall,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: GustoDesign.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Alger Centre, Didouche Mourad',
                        style: GustoDesign.textTheme.bodyMedium?.copyWith(
                          color: GustoDesign.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: GustoDesign.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // 3. PILL CATEGORIES
        SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category['label'] == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () =>
                        setState(() => _selectedCategory = category['label']),
                    borderRadius: GustoDesign.radiusMedium,
                    child: AnimatedContainer(
                      duration: 200.ms,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? GustoDesign.primary : Colors.white,
                        borderRadius: GustoDesign.radiusMedium,
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.withOpacity(0.2),
                        ),
                        boxShadow: isSelected ? GustoDesign.shadowSmall : [],
                      ),
                      child: Row(
                        children: [
                          if (category['icon'] != null) ...[
                            Icon(
                              category['icon'] as IconData,
                              size: 18,
                              color: isSelected
                                  ? Colors.white
                                  : GustoDesign.secondary,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            category['label'],
                            style: GustoDesign.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : GustoDesign.textDark,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).animate().fadeIn().slideX(),
          ),
        ),

        // 4. HERO LIST
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          sliver: _isLoading
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: SkeletonLoader(
                        width: double.infinity,
                        height: 280,
                      ),
                    ),
                    childCount: 3,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final cook = _filteredCooks[index];
                    return CookCard(
                      cook: cook,
                      onTap: () =>
                          context.push('/cook/${cook['id']}', extra: cook),
                    );
                  }, childCount: _filteredCooks.length),
                ),
        ),
      ],
    );
  }

  Widget _buildGlassButton(IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
        boxShadow: GustoDesign.shadowSmall,
      ),
      child: IconButton(
        icon: Icon(icon, color: GustoDesign.textDark, size: 20),
        onPressed: onTap,
      ),
    );
  }
}
