import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/login_page.dart';
import '../features/auth/auth_cubit.dart';
import '../features/auth/kyc_page.dart';
import '../features/auth/role_selection_page.dart';
import '../features/home/create_dish_page.dart';
import '../features/cook/cook_dashboard_page.dart';
import '../features/courier/courier_dashboard_page.dart';
import '../features/client/cart_page.dart';
import '../features/client/checkout_page.dart';
import '../features/client/search_page.dart';
import '../features/client/address_picker_page.dart';
import '../features/client/cook_profile_page.dart';
import '../features/client/dish_details_page.dart';
import '../features/client/order_history_page.dart';
import '../features/client/order_tracking_page.dart';
import '../features/client/address_management_page.dart';
import '../features/client/rating_page.dart';
import '../features/client/notifications_settings_page.dart';
import '../features/client/language_page.dart';
import '../features/client/help_support_page.dart';
import '../features/client/loyalty_page.dart';
import '../features/client/chat_page.dart';
import '../features/courier/courier_mission_page.dart';
import '../features/admin/admin_dashboard_page.dart';
import '../features/auth/onboarding_page.dart';
import '../features/client/reviews_page.dart';
import '../features/client/add_review_page.dart';
import '../features/client/order_success_page.dart';
import '../features/client/promo_codes_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../features/gusto_max/gusto_shell.dart';
import '../features/gusto_max/gusto_feed.dart';

import '../features/client/discover_page.dart';
import '../features/client/favorites_page.dart';
import '../features/client/profile_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/role-selection',
  routes: [
    // --- AUTH ---
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionPage(),
    ),
    GoRoute(
      path: '/login/:role',
      builder: (context, state) =>
          LoginPage(role: state.pathParameters['role'] ?? 'client'),
    ),
    GoRoute(path: '/kyc', builder: (context, state) => const KycPage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    // --- GUSTO MAX SHELL ---
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return GustoShell(navigationShell: navigationShell);
      },
      branches: [
        // 1. HOME
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(path: '/', builder: (context, state) => const GustoFeed()),
          ],
        ),
        // 2. DISCOVER
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverPage(),
            ),
          ],
        ),
        // 3. FAVORITES
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
          ],
        ),
        // 4. PROFILE
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    // --- DETAILS & OTHER PAGES (Keep existing logic) ---
    // DASHBOARDS & STANDALONE PAGES
    GoRoute(
      path: '/cook/dashboard',
      builder: (context, state) => const CookDashboardPage(),
    ),
    GoRoute(
      path: '/courier/dashboard',
      builder: (context, state) => const CourierDashboardPage(),
    ),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
    GoRoute(
      path: '/create-dish',
      builder: (context, state) => const CreateDishPage(),
    ),
    GoRoute(
      path: '/dish/:id',
      builder: (context, state) {
        final dish = state.extra as Map<String, dynamic>;
        return DishDetailsPage(dish: dish);
      },
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
    GoRoute(
      path: '/address-picker',
      builder: (context, state) => const AddressPickerPage(),
    ),
    GoRoute(
      path: '/cook/:id',
      builder: (context, state) {
        final cook = state.extra as Map<String, dynamic>;
        // Use the old CookProfilePage for now, or rebuild it later
        return CookProfilePage(cook: cook);
      },
    ),
    GoRoute(
      path: '/order-history',
      builder: (context, state) => const OrderHistoryPage(),
    ),
    GoRoute(
      path: '/order-tracking/:id',
      builder: (context, state) {
        final order = state.extra as Map<String, dynamic>;
        return OrderTrackingPage(order: order);
      },
    ),
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const AddressManagementPage(),
    ),
    GoRoute(
      path: '/rate-order/:id',
      builder: (context, state) {
        final order = state.extra as Map<String, dynamic>;
        return RatingPage(order: order);
      },
    ),
    GoRoute(
      path: '/notifications-settings',
      builder: (context, state) => const NotificationsSettingsPage(),
    ),
    GoRoute(
      path: '/language',
      builder: (context, state) => const LanguagePage(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpSupportPage(),
    ),
    GoRoute(path: '/loyalty', builder: (context, state) => const LoyaltyPage()),
    GoRoute(
      path: '/chat/:orderId',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ChatPage(
          order: extra['order'] as Map<String, dynamic>,
          targetRole: extra['targetRole'] as String? ?? 'courier',
          targetName: extra['targetName'] as String? ?? 'Livreur',
        );
      },
    ),
    GoRoute(
      path: '/courier-mission',
      builder: (context, state) => const CourierMissionPage(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardPage(),
    ),

    GoRoute(
      path: '/reviews',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ReviewsPage(
          title: extra['title'] as String,
          reviews: (extra['reviews'] as List).cast<Map<String, dynamic>>(),
        );
      },
    ),
    GoRoute(
      path: '/add-review',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return AddReviewPage(
          targetId: extra['targetId'] as String,
          targetName: extra['targetName'] as String,
        );
      },
    ),
    GoRoute(
      path: '/order-success',
      builder: (context, state) {
        final order = state.extra as Map<String, dynamic>?;
        return OrderSuccessPage(order: order);
      },
    ),
    GoRoute(
      path: '/promo-codes',
      builder: (context, state) => const PromoCodesPage(),
    ),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionPage(),
    ),
  ],
  redirect: (context, state) {
    final authState = context.read<AuthCubit>().state;
    final isLoggingIn =
        state.matchedLocation.startsWith('/login') ||
        state.matchedLocation == '/role-selection' ||
        state.matchedLocation == '/onboarding';

    if (!authState.isAuthenticated && !isLoggingIn) {
      return '/role-selection';
    }

    if (authState.isAuthenticated && isLoggingIn) {
      switch (authState.role) {
        case UserRole.cook:
          return '/cook/dashboard';
        case UserRole.courier:
          return '/courier/dashboard';
        case UserRole.admin:
          return '/admin';
        default:
          return '/';
      }
    }

    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Erreur: Route introuvable ${state.uri}')),
  ),
);
