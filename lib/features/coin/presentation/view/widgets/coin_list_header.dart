import 'package:flutter/material.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/l10n/app_localizations.dart';

class CoinListHeader extends StatelessWidget {
  const CoinListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final style = theme.textTheme.labelMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLarge,
        vertical: AppTheme.spacingSmall,
      ),
      child: Row(
        spacing: AppTheme.spacingMedium,
        children: [
          Expanded(child: Text(l10n.headerCoin, style: style)),
          Text(l10n.headerPrice, style: style),
          SizedBox(
            width: AppTheme.changePillWidth,
            child: Text(
              l10n.headerChange,
              textAlign: TextAlign.end,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
