import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/locale/locale_cubit.dart';
import 'package:kriptan/common/navigation/app_router.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/common/theme/theme_cubit.dart';
import 'package:kriptan/features/coin/data/coin_repository.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';
import 'package:kriptan/features/coin/presentation/bloc/list/coin_list_cubit.dart';
import 'package:kriptan/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ICoinRepository>(
      create: (context) => const CoinRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CoinListCubit(context.read<ICoinRepository>())..load(),
          ),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LocaleCubit()),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: context.watch<ThemeCubit>().state,
      locale: context.watch<LocaleCubit>().state,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
