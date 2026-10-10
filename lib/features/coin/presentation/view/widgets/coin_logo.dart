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
      child: Image.asset(
        coin.logo,
        width: AppTheme.avatarSize,
        height: AppTheme.avatarSize,
      ),
    );
  }
}
