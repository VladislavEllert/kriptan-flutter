import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/locale/locale_cubit.dart';
import 'package:kriptan/common/theme/theme_cubit.dart';
import 'package:kriptan/l10n/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: context.read<LocaleCubit>().toggle,
            child: Tooltip(
              message: l10n.actionToggleLanguage,
              child: Text(l10n.languageCode),
            ),
          ),
          IconButton(
            tooltip: l10n.actionToggleTheme,
            icon: Icon(isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: context.read<ThemeCubit>().toggle,
          ),
        ],
      ),
      body: body,
    );
  }
}
