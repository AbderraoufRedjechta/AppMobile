import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/mock_data_service.dart';

class SearchPage extends StatefulWidget {
  final Map<String, dynamic>? extra;

  const SearchPage({super.key, this.extra});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  late TabController _tabController;

  List<Map<String, dynamic>> _dishResults = [];
  List<Map<String, dynamic>> _cookResults = [];
  bool _isSearching = false;

  // Mock data
  final List<String> _recentSearches = [
    'Couscous Royal',
    'Chakhchoukha',
    'Mhadjeb',
    'Dolma',
  ];

  final List<String> _trendingSearches = [
    'Rechta',
    'Tajine Zitoune',
    'Chorba Frik',
    'Mtewem',
    'Bricks',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Check for passed category or query
    if (widget.extra != null && widget.extra!.containsKey('category')) {
      _searchController.text = widget.extra!['category'];
      _performSearch();
    } else {
      // Auto-focus search field only if no initial query
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocus.requestFocus();
      });
    }

    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _dishResults = [];
        _cookResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _dishResults = MockDataService.searchDishes(query);
      _cookResults = MockDataService.searchCooks(query);
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocus,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un plat ou cuisinier...',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(Icons.tune),
                                  onPressed: _showFilterBottomSheet,
                                ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs (only show when searching)
            if (_isSearching) ...[
              TabBar(
                controller: _tabController,
                labelColor: const Color(0xFFE65100),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFFE65100),
                tabs: [
                  Tab(text: 'Plats (${_dishResults.length})'),
                  Tab(text: 'Cuisiniers (${_cookResults.length})'),
                ],
              ),
            ],

            // Content
            Expanded(
              child: _isSearching
                  ? TabBarView(
                      controller: _tabController,
                      children: [_buildDishResults(), _buildCookResults()],
                    )
                  : _buildSuggestions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Récents',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _recentSearches.clear());
                  },
                  child: const Text('Effacer'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return ActionChip(
                  label: Text(search),
                  avatar: const Icon(Icons.history, size: 16),
                  backgroundColor: Colors.grey[100],
                  onPressed: () {
                    _searchController.text = search;
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Trending
          const Text(
            'Tendances',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._trendingSearches.map((search) {
            return ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.orange),
              title: Text(search),
              trailing: const Icon(Icons.north_west, size: 16),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                _searchController.text = search;
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDishResults() {
    if (_dishResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Aucun plat trouvé',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dishResults.length,
      itemBuilder: (context, index) {
        final dish = _dishResults[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.restaurant, color: Colors.white),
              ),
            ),
            title: Text(
              dish['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${dish['price']} DA • ${dish['cookName']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text('${dish['rating']}'),
              ],
            ),
            onTap: () {
              context.push('/dish/${dish['id']}', extra: dish);
            },
          ),
        );
      },
    );
  }

  Widget _buildCookResults() {
    if (_cookResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Aucun cuisinier trouvé',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _cookResults.length,
      itemBuilder: (context, index) {
        final cook = _cookResults[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFFE65100),
              child: Text(cook['avatar'], style: const TextStyle(fontSize: 24)),
            ),
            title: Text(
              cook['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              cook['specialty'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text('${cook['rating']}'),
                  ],
                ),
                Text(
                  '${cook['dishCount']} plats',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            onTap: () {
              context.push('/cook/${cook['id']}', extra: cook);
            },
          ),
        );
      },
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(500, 3000);
  String _sortBy = 'Relevance';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtres',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Price Range
          const Text(
            'Prix',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 5000,
            divisions: 50,
            activeColor: const Color(0xFFFF8C00),
            labels: RangeLabels(
              '${_priceRange.start.round()} DA',
              '${_priceRange.end.round()} DA',
            ),
            onChanged: (values) {
              setState(() => _priceRange = values);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_priceRange.start.round()} DA'),
              Text('${_priceRange.end.round()} DA'),
            ],
          ),
          const SizedBox(height: 24),

          // Sort By
          const Text(
            'Trier par',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children:
                [
                  'Pertinence',
                  'Prix croissant',
                  'Prix décroissant',
                  'Note',
                  'Temps',
                ].map((sort) {
                  final isSelected = _sortBy == sort;
                  return ChoiceChip(
                    label: Text(sort),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFF8C00).withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFFFF8C00)
                          : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    onSelected: (selected) {
                      if (selected) setState(() => _sortBy = sort);
                    },
                  );
                }).toList(),
          ),

          const Spacer(),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C00),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Appliquer les filtres',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
