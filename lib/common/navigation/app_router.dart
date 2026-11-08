import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptan/common/widgets/app_scaffold.dart';
import 'package:kriptan/features/coin/presentation/view/coin_detail_screen.dart';
import 'package:kriptan/features/coin/presentation/view/coin_list_screen.dart';
import 'package:kriptan/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const String list = '/';

  static String detail(String coinId) => '/coin/$coinId';
}

abstract final class AppRouter {
  static final GoRouter router = _create();

  static GoRouter _create() {
    // Without this flag push() leaves the browser address bar on "/".
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          builder: (context, state) => const CoinListScreen(),
          routes: [
            GoRoute(
              path: 'coin/:id',
              builder: (context, state) =>
                  CoinDetailScreen(coinId: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const _PageNotFoundScreen(),
    );
  }
}

class _PageNotFoundScreen extends StatelessWidget {
  const _PageNotFoundScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.appTitle,
      body: Center(child: Text(l10n.pageNotFound)),
    );
  }
}
