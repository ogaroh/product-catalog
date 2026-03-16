import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/catalog/data/repository/products_repository.dart';
import 'features/catalog/presentation/blocs/theme/theme_cubit.dart';
import 'features/catalog/presentation/blocs/theme/theme_state.dart';
import 'flavors.dart';
import 'l10n/l10n.dart';
import 'routing/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        // Repository provided at root so child cubits can read it.
        RepositoryProvider<ProductsRepository>(
          create: (_) => ProductsRepository(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Product Catalog',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.themeMode,
            themeAnimationDuration: const Duration(milliseconds: 400),
            themeAnimationCurve: Curves.easeInOut,
            routerConfig: appRouter,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              // Show flavor banner in non-prod builds
              final flavor = getFlavor();
              if (flavor == Flavor.prod) return child!;
              return Banner(
                message: flavor.name.toUpperCase(),
                location: BannerLocation.topEnd,
                color: flavor == Flavor.stag
                    ? Colors.orange
                    : Colors.deepPurple,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
