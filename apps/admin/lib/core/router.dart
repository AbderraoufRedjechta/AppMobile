import 'package:go_router/go_router.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/users/user_management_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UserManagementPage(),
    ),
  ],
);
