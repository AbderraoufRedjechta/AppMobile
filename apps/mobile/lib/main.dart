import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/gusto_theme.dart';
import 'core/router.dart';
import 'features/auth/auth_cubit.dart';
import 'features/client/cart_cubit.dart';
import 'features/client/favorites_cubit.dart';

import 'features/client/promo_cubit.dart';
import 'core/theme_cubit.dart';

// REBUILD ENTRY POINT
void main() {
  // Speed up animations for debugging/dev
  Animate.restartOnHotReload = true;
  runApp(const GustoApp());
}

class GustoApp extends StatelessWidget {
  const GustoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<PromoCubit>(create: (context) => PromoCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Gusto MAX',
            debugShowCheckedModeBanner: false,
            // Light Theme
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: GustoTheme.primary,
                primary: GustoTheme.primary,
                secondary: GustoTheme.secondary,
                surface: GustoTheme.surface,
                background: GustoTheme.background,
              ),
              scaffoldBackgroundColor: GustoTheme.background,
              textTheme: GustoTheme.textTheme,
            ),
            // Dark Theme
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: GustoTheme.primary,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
