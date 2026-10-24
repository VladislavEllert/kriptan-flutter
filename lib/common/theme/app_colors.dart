import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color orange = Color(0xFFF7A600);
  static const Color ink = Color(0xFF0B0B0F);

  static const Color darkBackground = Color(0xFF0B0B0F);
  static const Color darkSurfaceContainer = Color(0xFF17181E);
  static const Color darkSurfaceVariant = Color(0xFF22232A);
  static const Color darkOnSurface = Color(0xFFF5F5F7);
  static const Color darkOnSurfaceVariant = Color(0xFF8A8D97);

  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainer = Color(0xFFF4F5F7);
  static const Color lightSurfaceVariant = Color(0xFFE9EAEE);
  static const Color lightOnSurface = Color(0xFF121214);
  static const Color lightOnSurfaceVariant = Color(0xFF6F7380);

  // Price change colors carry data meaning, so they stay the same in both themes.
  static const Color priceUp = Color(0xFF20B26C);
  static const Color priceDown = Color(0xFFEF454A);
  static const Color onPriceChange = Color(0xFFFFFFFF);
}
