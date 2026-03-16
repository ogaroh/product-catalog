import 'package:flutter/material.dart';

/// Semantic color tokens for the product catalog design system.
/// Both light and dark palettes are defined here.
abstract final class AppColors {
  // ──────────────────────────────────────────────────────────
  // Brand palette
  // ──────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6366F1); // Vibrant indigo
  static const Color primaryDark = Color(0xFFA5B4FC); // Soft indigo (dark mode)
  static const Color secondary = Color(0xFF8B5CF6); // Rich violet
  static const Color secondaryDark = Color(
    0xFFC4B5FD,
  ); // Soft violet (dark mode)

  // Accent gradient anchors
  static const Color accentStart = Color(0xFF6366F1); // Indigo
  static const Color accentEnd = Color(0xFFEC4899); // Pink

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
  static const Color discountGradientStart = Color(0xFFEF4444);
  static const Color discountGradientEnd = Color(0xFFEC4899);

  // ──────────────────────────────────────────────────────────
  // Light surface
  // ──────────────────────────────────────────────────────────
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(
    0xFFF1F0FB,
  ); // Light lavender tint
  static const Color backgroundLight = Color(0xFFFAF9FE); // Subtle warm white
  static const Color onSurfaceLight = Color(0xFF1E1B4B); // Deep indigo-black
  static const Color onSurfaceVariantLight = Color(0xFF64748B); // Slate
  static const Color borderLight = Color(0xFFE2E0F0); // Soft lavender border

  // ──────────────────────────────────────────────────────────
  // Dark surface
  // ──────────────────────────────────────────────────────────
  static const Color surfaceDark = Color(0xFF1E1B2E); // Deep purple-black
  static const Color surfaceVariantDark = Color(
    0xFF2D2A42,
  ); // Elevated purple-black
  static const Color backgroundDark = Color(0xFF13111C); // True dark
  static const Color onSurfaceDark = Color(0xFFF1F0FB);
  static const Color onSurfaceVariantDark = Color(0xFFA3A1B6);
  static const Color borderDark = Color(0xFF3B3852); // Subtle purple border

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
