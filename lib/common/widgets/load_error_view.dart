import 'package:flutter/material.dart';
import 'package:kriptan/common/network/load_exception.dart';
import 'package:kriptan/common/theme/app_theme.dart';
import 'package:kriptan/l10n/app_localizations.dart';

// No retry button for "not found": retrying will not make the coin appear.
class LoadErrorView extends StatelessWidget {
  const LoadErrorView({super.key, required this.error, required this.onRetry});

  final LoadException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final message = switch (error) {
      NoConnectionException() => l10n.errorNoConnection,
      TimeoutLoadException() => l10n.errorTimeout,
      NotFoundException() => l10n.coinNotFound,
      TooManyRequestsException() => l10n.errorTooManyRequests,
      ServerException(:final statusCode) => l10n.errorServer(
        statusCode?.toString() ?? '?',
      ),
      BadResponseException() => l10n.errorBadResponse,
    };
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppTheme.spacingMedium,
        children: [
          Text(message, textAlign: TextAlign.center),
          if (error is! NotFoundException)
            FilledButton.tonal(
              onPressed: onRetry,
              child: Text(l10n.actionRetry),
            ),
        ],
      ),
    );
  }
}
