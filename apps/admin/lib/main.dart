import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router.dart';
import 'core/theme.dart';
import 'core/api_client.dart';
import 'services/auth_api_service.dart';
import 'services/user_api_service.dart';
import 'services/dashboard_api_service.dart';
import 'features/users/cubit/user_cubit.dart';
import 'features/dashboard/cubit/dashboard_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create API client and services
  final apiClient = ApiClient();
  final authApiService = AuthApiService(apiClient);

  // Auto-login as admin for development
  try {
    final token = await authApiService.login('admin@tayabli.com', 'password');
    apiClient.setAuthToken(token);
    print('✅ Logged in as admin');
  } catch (e) {
    print('❌ Failed to login: $e');
  }

  final userApiService = UserApiService(apiClient);
  final dashboardApiService = DashboardApiService(apiClient);

  runApp(
    AdminApp(
      userApiService: userApiService,
      dashboardApiService: dashboardApiService,
    ),
  );
}

class AdminApp extends StatelessWidget {
  final UserApiService userApiService;
  final DashboardApiService dashboardApiService;

  const AdminApp({
    super.key,
    required this.userApiService,
    required this.dashboardApiService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(userApiService)..loadUsers(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(dashboardApiService)..loadStats(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Tayabli Admin',
        debugShowCheckedModeBanner: false,
        theme: adminTheme,
        routerConfig: router,
      ),
    );
  }
}
