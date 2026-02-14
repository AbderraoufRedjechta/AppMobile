class MockDataService {
  // Plats algériens avec données complètes
  static final List<Map<String, dynamic>> dishes = [
    {
      'id': 1,
      'name': 'Couscous Royal',
      'description':
          'Couscous traditionnel avec viande d\'agneau, poulet, merguez et légumes de saison',
      'price': 1200,
      'cookId': 1,
      'cookName': 'Fatima Benali',
      'cookAvatar': '👩‍🍳',
      'image': 'couscous_royal.png',
      'rating': 4.8,
      'reviewCount': 156,
      'prepTime': 45,
      'stock': 8,
      'category': 'Plats principaux',
      'tags': ['Traditionnel', 'Familial', 'Halal'],
    },
    {
      'id': 2,
      'name': 'Chakhchoukha',
      'description':
          'Galettes de pain déchiquetées dans une sauce rouge épicée avec viande',
      'price': 800,
      'cookId': 2,
      'cookName': 'Samira Khelil',
      'cookAvatar': '👩‍🍳',
      'image': 'chakhchoukha.png',
      'rating': 4.6,
      'reviewCount': 89,
      'prepTime': 60,
      'stock': 5,
      'category': 'Plats principaux',
      'tags': ['Traditionnel', 'Épicé', 'Biskra'],
    },
    {
      'id': 3,
      'name': 'Rechta',
      'description': 'Nouilles fraîches maison avec sauce blanche au poulet',
      'price': 700,
      'cookId': 3,
      'cookName': 'Aicha Ouali',
      'cookAvatar': '👩‍🍳',
      'image': 'rechta.png',
      'rating': 4.7,
      'reviewCount': 124,
      'prepTime': 40,
      'stock': 10,
      'category': 'Plats principaux',
      'tags': ['Traditionnel', 'Fait maison'],
    },
    {
      'id': 4,
      'name': 'Dolma',
      'description':
          'Légumes farcis (courgettes, poivrons, tomates) à la viande hachée et riz',
      'price': 650,
      'cookId': 1,
      'cookName': 'Fatima Benali',
      'cookAvatar': '👩‍🍳',
      'image': 'dolma.png',
      'rating': 4.9,
      'reviewCount': 203,
      'prepTime': 50,
      'stock': 12,
      'category': 'Plats principaux',
      'tags': ['Léger', 'Santé', 'Traditionnel'],
    },
    {
      'id': 5,
      'name': 'Mhadjeb',
      'description': 'Crêpes feuilletées farcies aux oignons et tomates',
      'price': 300,
      'cookId': 4,
      'cookName': 'Khadija Meziane',
      'cookAvatar': '👩‍🍳',
      'image': 'tajine_zitoune.png', // Temporary fallback
      'rating': 4.5,
      'reviewCount': 178,
      'prepTime': 20,
      'stock': 15,
      'category': 'Street Food',
      'tags': ['Rapide', 'Végétarien', 'Street Food'],
    },
    {
      'id': 6,
      'name': 'Tajine Zitoune',
      'description': 'Tajine de poulet aux olives et citron confit',
      'price': 900,
      'cookId': 2,
      'cookName': 'Samira Khelil',
      'cookAvatar': '👩‍🍳',
      'image': 'tajine_zitoune.png',
      'rating': 4.7,
      'reviewCount': 145,
      'prepTime': 55,
      'stock': 6,
      'category': 'Plats principaux',
      'tags': ['Traditionnel', 'Citron', 'Olives'],
    },
    {
      'id': 7,
      'name': 'Chorba Frik',
      'description':
          'Soupe traditionnelle au blé vert concassé et viande d\'agneau',
      'price': 400,
      'cookId': 3,
      'cookName': 'Aicha Ouali',
      'cookAvatar': '👩‍🍳',
      'image': 'berkoukes.png', // Fallback to something similar
      'rating': 4.8,
      'reviewCount': 167,
      'prepTime': 30,
      'stock': 20,
      'category': 'Soupes',
      'tags': ['Soupe', 'Réconfortant', 'Ramadan'],
    },
    {
      'id': 8,
      'name': 'Mtewem',
      'description': 'Ragoût de viande aux légumes et épices',
      'price': 750,
      'cookId': 1,
      'cookName': 'Fatima Benali',
      'cookAvatar': '👩‍🍳',
      'image': 'rechta.png', // Fallback
      'rating': 4.6,
      'reviewCount': 92,
      'prepTime': 45,
      'stock': 7,
      'category': 'Plats principaux',
      'tags': ['Traditionnel', 'Épicé'],
    },
    {
      'id': 9,
      'name': 'Bourek',
      'description': 'Feuilletés croustillants farcis à la viande hachée',
      'price': 350,
      'cookId': 4,
      'cookName': 'Khadija Meziane',
      'cookAvatar': '👩‍🍳',
      'image': 'dolma.png', // Fallback
      'rating': 4.9,
      'reviewCount': 234,
      'prepTime': 25,
      'stock': 18,
      'category': 'Entrées',
      'tags': ['Croustillant', 'Populaire', 'Ramadan'],
    },
    {
      'id': 10,
      'name': 'Garantita',
      'description': 'Flan de pois chiches cuit au four, spécialité oranaise',
      'price': 250,
      'cookId': 5,
      'cookName': 'Nadia Belkacem',
      'cookAvatar': '👩‍🍳',
      'image': 'couscous_royal.png', // Fallback
      'rating': 4.4,
      'reviewCount': 87,
      'prepTime': 15,
      'stock': 25,
      'category': 'Street Food',
      'tags': ['Oran', 'Végétarien', 'Petit-déj'],
    },
    {
      'id': 11,
      'name': 'Makrout',
      'description': 'Pâtisserie aux dattes frite et trempée dans le miel',
      'price': 500,
      'cookId': 6,
      'cookName': 'Malika Hamidi',
      'cookAvatar': '👩‍🍳',
      'image': 'chakhchoukha.png', // Fallback
      'rating': 4.9,
      'reviewCount': 312,
      'prepTime': 35,
      'stock': 30,
      'category': 'Desserts',
      'tags': ['Sucré', 'Dattes', 'Miel'],
    },
    {
      'id': 12,
      'name': 'Zlabia',
      'description': 'Pâtisserie en forme de spirale trempée dans le miel',
      'price': 400,
      'cookId': 6,
      'cookName': 'Malika Hamidi',
      'cookAvatar': '👩‍🍳',
      'image': 'rechta.png', // Fallback
      'rating': 4.7,
      'reviewCount': 198,
      'prepTime': 30,
      'stock': 20,
      'category': 'Desserts',
      'tags': ['Sucré', 'Miel', 'Ramadan'],
    },
    {
      'id': 13,
      'name': 'Kalb Ellouz',
      'description': 'Gâteau de semoule en forme de losange au sirop',
      'price': 450,
      'cookId': 6,
      'cookName': 'Malika Hamidi',
      'cookAvatar': '👩‍🍳',
      'image': 'couscous_royal.png', // Fallback
      'rating': 4.8,
      'reviewCount': 156,
      'prepTime': 40,
      'stock': 15,
      'category': 'Desserts',
      'tags': ['Sucré', 'Semoule', 'Traditionnel'],
    },
    {
      'id': 14,
      'name': 'Baklawa',
      'description': 'Pâtisserie feuilletée aux amandes et miel',
      'price': 600,
      'cookId': 6,
      'cookName': 'Malika Hamidi',
      'cookAvatar': '👩‍🍳',
      'image': 'dolma.png', // Fallback
      'rating': 5.0,
      'reviewCount': 267,
      'prepTime': 45,
      'stock': 12,
      'category': 'Desserts',
      'tags': ['Sucré', 'Amandes', 'Premium'],
    },
    {
      'id': 15,
      'name': 'Bricks à l\'Oeuf',
      'description':
          'Feuilles de brick croustillantes farcies à l\'oeuf et thon',
      'price': 300,
      'cookId': 4,
      'cookName': 'Khadija Meziane',
      'cookAvatar': '👩‍🍳',
      'image': 'berkoukes.png', // Fallback
      'rating': 4.6,
      'reviewCount': 143,
      'prepTime': 20,
      'stock': 16,
      'category': 'Entrées',
      'tags': ['Croustillant', 'Rapide', 'Oeuf'],
    },
  ];

  // Profils de cuisiniers
  static final List<Map<String, dynamic>> cooks = [
    {
      'id': 1,
      'name': 'Fatima Benali',
      'avatar': '👩‍🍳',
      'specialty': 'Couscous et plats traditionnels',
      'rating': 4.8,
      'reviewCount': 451,
      'dishCount': 12,
      'bio':
          'Passionnée de cuisine algéroise depuis 20 ans. Spécialiste du couscous royal et des plats familiaux.',
      'location': 'Alger Centre',
      'joinedDate': '2022-03-15',
    },
    {
      'id': 2,
      'name': 'Samira Khelil',
      'avatar': '👩‍🍳',
      'specialty': 'Cuisine de l\'Est algérien',
      'rating': 4.7,
      'reviewCount': 234,
      'dishCount': 8,
      'bio':
          'Originaire de Biskra, je vous fais découvrir les saveurs authentiques de l\'Est.',
      'location': 'Bab Ezzouar',
      'joinedDate': '2022-06-20',
    },
    {
      'id': 3,
      'name': 'Aicha Ouali',
      'avatar': '👩‍🍳',
      'specialty': 'Pâtes fraîches et soupes',
      'rating': 4.7,
      'reviewCount': 291,
      'dishCount': 10,
      'bio': 'Tout est fait maison ! Rechta, chorba et plats réconfortants.',
      'location': 'Hydra',
      'joinedDate': '2021-11-10',
    },
    {
      'id': 4,
      'name': 'Khadija Meziane',
      'avatar': '👩‍🍳',
      'specialty': 'Street food algérienne',
      'rating': 4.6,
      'reviewCount': 555,
      'dishCount': 15,
      'bio':
          'Mhadjeb, bourek, bricks... La street food algérienne comme vous l\'aimez !',
      'location': 'Kouba',
      'joinedDate': '2022-01-05',
    },
    {
      'id': 5,
      'name': 'Nadia Belkacem',
      'avatar': '👩‍🍳',
      'specialty': 'Spécialités oranaises',
      'rating': 4.5,
      'reviewCount': 167,
      'dishCount': 6,
      'bio':
          'Garantita, karantika et autres délices d\'Oran directement chez vous.',
      'location': 'Bir Mourad Raïs',
      'joinedDate': '2023-02-14',
    },
    {
      'id': 6,
      'name': 'Malika Hamidi',
      'avatar': '👩‍🍳',
      'specialty': 'Pâtisserie orientale',
      'rating': 4.9,
      'reviewCount': 933,
      'dishCount': 20,
      'bio':
          'Pâtissière professionnelle. Makrout, zlabia, baklawa et bien plus encore !',
      'location': 'Dely Ibrahim',
      'joinedDate': '2021-09-01',
    },
  ];

  // Commandes de démonstration
  static final List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD-001',
      'date': '2025-11-20',
      'status': 'delivered',
      'total': 2400,
      'items': [
        {
          'dishId': 1,
          'dishName': 'Couscous Royal',
          'quantity': 2,
          'price': 1200,
        },
      ],
      'cookName': 'Fatima Benali',
      'deliveryAddress': '12 Rue Didouche Mourad, Alger',
    },
    {
      'id': 'ORD-002',
      'date': '2025-11-21',
      'status': 'DELIVERING',
      'total': 1550,
      'items': [
        {
          'dishId': 6,
          'dishName': 'Tajine Zitoune',
          'quantity': 1,
          'price': 900,
        },
        {'dishId': 9, 'dishName': 'Bourek', 'quantity': 1, 'price': 350},
        {'dishId': 5, 'dishName': 'Mhadjeb', 'quantity': 1, 'price': 300},
      ],
      'cookName': 'Samira Khelil',
      'deliveryAddress': '12 Rue Didouche Mourad, Alger',
    },
    {
      'id': 'ORD-003',
      'date': '2025-11-18',
      'status': 'delivered',
      'total': 1100,
      'items': [
        {'dishId': 11, 'dishName': 'Makrout', 'quantity': 1, 'price': 500},
        {'dishId': 14, 'dishName': 'Baklawa', 'quantity': 1, 'price': 600},
      ],
      'cookName': 'Malika Hamidi',
      'deliveryAddress': '12 Rue Didouche Mourad, Alger',
    },
    {
      'id': 'ORD-004',
      'date': '2025-11-15',
      'status': 'cancelled',
      'total': 700,
      'items': [
        {'dishId': 3, 'dishName': 'Rechta', 'quantity': 1, 'price': 700},
      ],
      'cookName': 'Aicha Ouali',
      'deliveryAddress': '12 Rue Didouche Mourad, Alger',
    },
  ];

  // Méthodes helper
  static List<Map<String, dynamic>> getDishes() => dishes;

  static List<Map<String, dynamic>> getCooks() => cooks;

  static List<Map<String, dynamic>> getOrders() => orders;

  static Map<String, dynamic>? getDishById(int id) {
    try {
      return dishes.firstWhere((dish) => dish['id'] == id);
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic>? getCookById(int id) {
    try {
      return cooks.firstWhere((cook) => cook['id'] == id);
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> getDishesByCook(int cookId) {
    return dishes.where((dish) => dish['cookId'] == cookId).toList();
  }

  static List<Map<String, dynamic>> searchDishes(String query) {
    final lowerQuery = query.toLowerCase();
    return dishes.where((dish) {
      final name = (dish['name'] as String).toLowerCase();
      final description = (dish['description'] as String).toLowerCase();
      final tags = (dish['tags'] as List).join(' ').toLowerCase();
      return name.contains(lowerQuery) ||
          description.contains(lowerQuery) ||
          tags.contains(lowerQuery);
    }).toList();
  }

  static List<Map<String, dynamic>> searchCooks(String query) {
    final lowerQuery = query.toLowerCase();
    return cooks.where((cook) {
      final name = (cook['name'] as String).toLowerCase();
      final specialty = (cook['specialty'] as String).toLowerCase();
      return name.contains(lowerQuery) || specialty.contains(lowerQuery);
    }).toList();
  }
}
