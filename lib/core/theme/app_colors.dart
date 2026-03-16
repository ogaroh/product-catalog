import 'package:flutter/material.dart';

/// Semantic color tokens for the product catalog design system.
/// Both light and dark palettes are defined here.
abstract final class AppColors {
  // ──────────────────────────────────────────────────────────
  // Brand palette
  // ──────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF4F46E5);       // Indigo 600
  static const Color primaryDark = Color(0xFF818CF8);   // Indigo 400 (dark mode)
  static const Color secondary = Color(0xFF06B6D4);     // Cyan 500
  static const Color secondaryDark = Color(0xFF22D3EE); // Cyan 400 (dark mode)

  // ──────────────────────────────────────────────────────────
  // Semantic
  // ──────────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color rating = Color(0xFFF59E0B); // amber stars

  // Discount badge
  static const Color discountBg = Color(0xFFEF4444);
  static const Color discountFg = Color(0xFFFFFFFF);

  // ──────────────────────────────────────────────────────────
  // Light surface
  // ──────────────────────────────────────────────────────────
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF3F4F6);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color onSurfaceLight = Color(0xFF111827);
  static const Color onSurfaceVariantLight = Color(0xFF6B7280);
  static const Color borderLight = Color(0xFFE5E7EB);

  // ──────────────────────────────────────────────────────────
  // Dark surface
  // ──────────────────────────────────────────────────────────
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color surfaceVariantDark = Color(0xFF374151);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color onSurfaceDark = Color(0xFFF9FAFB);
  static const Color onSurfaceVariantDark = Color(0xFF9CA3AF);
  static const Color borderDark = Color(0xFF374151);

  // ──────────────────────────────────────────────────────────
  // Shimmer
  // ──────────────────────────────────────────────────────────
  static const Color shimmerBaseLight = Color(0xFFE5E7EB);
  static const Color shimmerHighlightLight = Color(0xFFF9FAFB);
  static const Color shimmerBaseDark = Color(0xFF374151);
  static const Color shimmerHighlightDark = Color(0xFF4B5563);

  // ──────────────────────────────────────────────────────────
  // Cached data banner
  // ──────────────────────────────────────────────────────────
  static const Color cachedBannerBg = Color(0xFFFEF3C7);
  static const Color cachedBannerFg = Color(0xFF92400E);
  static const Color cachedBannerBgDark = Color(0xFF451A03);
  static const Color cachedBannerFgDark = Color(0xFFFCD34D);
}
