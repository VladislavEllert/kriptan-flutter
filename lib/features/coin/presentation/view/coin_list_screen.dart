import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/common/widgets/app_scaffold.dart';
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
                child: SearchField(
                  onChanged: context.read<CoinListCubit>().search,
                ),
              ),
              Expanded(
                child: BlocBuilder<CoinListCubit, CoinListState>(
                  builder: (context, state) => switch (state) {
                    CoinListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CoinListLoaded(:final coins) when coins.isEmpty => Center(
                      child: Text(l10n.nothingFound),
                    ),
                    CoinListLoaded(:final coins) => Column(
                      children: [
                        const CoinListHeader(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: coins.length,
                            itemBuilder: (context, index) =>
                                CoinRow(coin: coins[index]),
                          ),
                        ),
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
