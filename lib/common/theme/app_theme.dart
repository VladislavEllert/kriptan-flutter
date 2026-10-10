import 'package:flutter/material.dart';
import 'package:kriptan/common/theme/app_colors.dart';

abstract final class AppTheme {
  static const double spacingSmall = 8;
  static const double spacingMedium = 12;
  static const double spacingLarge = 16;
  static const double avatarSize = 36;
  static const double changePillWidth = 84;
  static const double contentMaxWidth = 720;

  static final ThemeData dark = _build(
    ColorScheme.fromSeed(
      seedColor: AppColors.orange,
      brightness: Brightness.dark,
      primary: AppColors.orange,
      onPrimary: AppColors.ink,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkOnSurface,
      surfaceContainer: AppColors.darkSurfaceContainer,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    ),
  );

  static final ThemeData light = _build(
    ColorScheme.fromSeed(
      seedColor: AppColors.orange,
      brightness: Brightness.light,
      primary: AppColors.orange,
      onPrimary: AppColors.ink,
      surface: AppColors.lightBackground,
      onSurface: AppColors.lightOnSurface,
      surfaceContainer: AppColors.lightSurfaceContainer,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
    ),
  );

  static ThemeData _build(ColorScheme colorScheme) => ThemeData(
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      scrolledUnderElevation: 0,
    ),
  );
}
