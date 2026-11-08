import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/common/widgets/app_scaffold.dart';
import 'package:kriptan/common/widgets/load_error_view.dart';
import 'package:kriptan/features/coin/presentation/bloc/list/coin_list_cubit.dart';
import 'package:kriptan/features/coin/presentation/bloc/list/coin_list_state.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/coin_list_header.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/coin_row.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/search_field.dart';
import 'package:kriptan/l10n/app_localizations.dart';

class CoinListScreen extends StatelessWidget {
  const CoinListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<CoinListCubit>();
    return AppScaffold(
      title: l10n.appTitle,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLarge,
                  vertical: AppTheme.spacingSmall,
                ),
                child: SearchField(onChanged: cubit.search),
              ),
              Expanded(
                child: BlocBuilder<CoinListCubit, CoinListState>(
                  builder: (context, state) => switch (state) {
                    CoinListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CoinListFailure(:final error) => Center(
                      child: LoadErrorView(error: error, onRetry: cubit.load),
                    ),
                    CoinListLoaded(:final coins) when coins.isEmpty => Center(
                      child: Text(l10n.nothingFound),
                    ),
                    CoinListLoaded() => Column(
                      children: [
                        const CoinListHeader(),
                        Expanded(child: _CoinList(state: state)),
                      ],
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stateful because it owns the ScrollController that tells when the end is near.
class _CoinList extends StatefulWidget {
  const _CoinList({required this.state});

  final CoinListLoaded state;

  @override
  State<_CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<_CoinList> {
  static const double _loadMoreDistance = 300;

  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.extentAfter < _loadMoreDistance) {
      context.read<CoinListCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final coins = state.coins;
    final showFooter = state.isLoadingMore || state.loadMoreError != null;
    return ListView.builder(
      controller: _controller,
      itemCount: coins.length + (showFooter ? 1 : 0),
      itemBuilder: (context, index) => index < coins.length
          ? CoinRow(coin: coins[index])
          : _Footer(state: state),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state});

  final CoinListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;
    return Center(
      child: error == null
          ? const Padding(
              padding: EdgeInsets.all(AppTheme.spacingLarge),
              child: CircularProgressIndicator(),
            )
          : LoadErrorView(
              error: error,
              onRetry: context.read<CoinListCubit>().loadMore,
            ),
    );
  }
}
