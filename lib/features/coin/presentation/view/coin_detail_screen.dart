import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/common/widgets/app_scaffold.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';
import 'package:kriptan/features/coin/presentation/bloc/detail/coin_detail_cubit.dart';
import 'package:kriptan/features/coin/presentation/bloc/detail/coin_detail_state.dart';
import 'package:kriptan/features/coin/presentation/utils/coin_format.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/change_pill.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/coin_logo.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/coin_row.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/info_section.dart';
import 'package:kriptan/l10n/app_localizations.dart';

class CoinDetailScreen extends StatelessWidget {
  const CoinDetailScreen({super.key, required this.coinId});

  final String coinId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) =>
          CoinDetailCubit(context.read<ICoinRepository>())..load(coinId),
      child: BlocBuilder<CoinDetailCubit, CoinDetailState>(
        builder: (context, state) => switch (state) {
          CoinDetailLoading() => AppScaffold(
            title: l10n.appTitle,
            body: const Center(child: CircularProgressIndicator()),
          ),
          CoinDetailNotFound() => AppScaffold(
            title: l10n.appTitle,
            body: Center(child: Text(l10n.coinNotFound)),
          ),
          CoinDetailLoaded(:final coin, :final neighbours) => AppScaffold(
            title: coin.name,
            body: _CoinDetails(coin: coin, neighbours: neighbours),
          ),
        },
      ),
    );
  }
}

class _CoinDetails extends StatelessWidget {
  const _CoinDetails({required this.coin, required this.neighbours});

  final CoinModel coin;
  final List<CoinModel> neighbours;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final rank = coin.marketCapRank;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppTheme.spacingLarge,
            children: [
              Row(
                spacing: AppTheme.spacingMedium,
                children: [
                  CoinLogo(coin: coin),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coin.displaySymbol,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (rank != null)
                        Text(
                          l10n.rank(rank),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      coin.displayPrice,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ChangePill(coin: coin),
                ],
              ),
              InfoSection(
                title: l10n.sectionMarket,
                children: [
                  InfoRow(label: l10n.marketCap, value: coin.displayMarketCap),
                  InfoRow(
                    label: l10n.volume24h,
                    value: coin.displayTotalVolume,
                  ),
                  InfoRow(label: l10n.high24h, value: coin.displayHigh24h),
                  InfoRow(label: l10n.low24h, value: coin.displayLow24h),
                  InfoRow(label: l10n.allTimeHigh, value: coin.displayAth),
                ],
              ),
              InfoSection(
                title: l10n.sectionSupply,
                children: [
                  InfoRow(
                    label: l10n.circulatingSupply,
                    value: coin.displayCirculatingSupply,
                  ),
                  InfoRow(
                    label: l10n.totalSupply,
                    value: coin.displayTotalSupply,
                  ),
                  InfoRow(label: l10n.maxSupply, value: coin.displayMaxSupply),
                ],
              ),
              InfoSection(
                title: l10n.sectionNeighbours,
                children: [
                  for (final neighbour in neighbours) CoinRow(coin: neighbour),
                ],
              ),
              Text(
                l10n.lastUpdated(coin.displayLastUpdated),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
