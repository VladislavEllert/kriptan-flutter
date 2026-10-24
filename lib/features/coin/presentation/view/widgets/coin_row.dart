import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptan/common/navigation/app_router.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/presentation/utils/coin_format.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/change_pill.dart';
import 'package:kriptan/features/coin/presentation/view/widgets/coin_logo.dart';

class CoinRow extends StatelessWidget {
  const CoinRow({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const bold = TextStyle(fontWeight: FontWeight.bold);
    return InkWell(
      onTap: () => context.push(AppRoutes.detail(coin.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLarge,
          vertical: AppTheme.spacingMedium,
        ),
        child: Row(
          spacing: AppTheme.spacingMedium,
          children: [
            CoinLogo(coin: coin),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(coin.displaySymbol, style: bold),
                  Text(
                    '${coin.name} | ${coin.displayVolume}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(coin.displayPrice, style: bold),
            ChangePill(coin: coin),
          ],
        ),
      ),
    );
  }
}
