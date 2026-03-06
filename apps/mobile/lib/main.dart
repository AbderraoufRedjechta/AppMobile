import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Generated
import 'core/services/notifications_service.dart';
import 'core/api_client.dart';
import 'core/theme_cubit.dart';
import 'core/theme/wajabat_theme.dart';
import 'features/auth/auth_api_service.dart';
import 'features/auth/auth_cubit.dart';
import 'features/client/cart_cubit.dart';
import 'features/client/favorites_cubit.dart';
import 'features/client/promo_cubit.dart';
import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;
  
  final apiClient = ApiClient();
  final authApiService = AuthApiService(apiClient);
  final notificationsService = NotificationsService();
  
  await notificationsService.initialize();

  runApp(WajabatApp(
    apiClient: apiClient,
    authApiService: authApiService,
    notificationsService: notificationsService,
  ));
}

class WajabatApp extends StatelessWidget {
  final ApiClient apiClient;
  final AuthApiService authApiService;
  final NotificationsService notificationsService;

  const WajabatApp({
    super.key,
    required this.apiClient,
    required this.authApiService,
    required this.notificationsService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authService: authApiService,
            apiClient: apiClient,
          ),
        ),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<PromoCubit>(create: (context) => PromoCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Wajabat',
            debugShowCheckedModeBanner: false,
            theme: WajabatTheme.lightTheme,
            darkTheme: WajabatTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: router,
            localizationsDelegates: const [
              // AppLocalizations.delegate, // Generated
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
          );
        },
      ),
    );
  }
}
