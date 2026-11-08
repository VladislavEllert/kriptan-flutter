import 'package:flutter/material.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/presentation/utils/coin_format.dart';

class CoinLogo extends StatelessWidget {
  const CoinLogo({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        coin.image,
        width: AppTheme.avatarSize,
        height: AppTheme.avatarSize,
        errorBuilder: (context, error, stackTrace) => _Initial(coin: coin),
      ),
    );
  }
}

// Shown when the logo cannot be downloaded.
class _Initial extends StatelessWidget {
  const _Initial({required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: AppTheme.avatarSize,
      height: AppTheme.avatarSize,
      color: colors.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Text(
        coin.displaySymbol.characters.first,
        style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
