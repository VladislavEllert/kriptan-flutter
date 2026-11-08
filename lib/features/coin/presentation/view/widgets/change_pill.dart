import 'package:flutter/material.dart';
import 'package:kriptan/common/theme/app_colors.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/presentation/utils/coin_format.dart';

class ChangePill extends StatelessWidget {
  const ChangePill({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    final percent = coin.priceChangePercentage24h;
    final color = switch (percent) {
      null => Theme.of(context).colorScheme.surfaceContainerHighest,
      >= 0 => AppColors.priceUp,
      _ => AppColors.priceDown,
    };
    return Container(
      width: AppTheme.changePillWidth,
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTheme.spacingSmall),
      ),
      child: Text(
        coin.displayChange,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.onPriceChange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
