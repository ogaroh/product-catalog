import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// Centralised ThemeData factory.
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? AppColors.primaryDark : AppColors.primary,
      onPrimary: Colors.white,
      secondary: isDark ? AppColors.secondaryDark : AppColors.secondary,
      onSecondary: isDark ? Colors.black : Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      onSurface: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
      surfaceContainerHighest:
          isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
      onSurfaceVariant: isDark
          ? AppColors.onSurfaceVariantDark
          : AppColors.onSurfaceVariantLight,
      outline: isDark ? AppColors.borderDark : AppColors.borderLight,
    );

    final baseTextTheme = GoogleFonts.nunitoTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,

      // ── Typography ──────────────────────────────────────────
      textTheme: baseTextTheme.copyWith(
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // ── AppBar ───────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // ── Card ─────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: AppSpacing.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 0.5,
          ),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Input / Search ───────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppColors.surfaceVariantDark
            : AppColors.surfaceVariantLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          borderSide: BorderSide(
            color: isDark ? AppColors.primaryDark : AppColors.primary,
            width: 2,
          ),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // ── Chip ─────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
        selectedColor:
            isDark ? AppColors.primaryDark : AppColors.primary,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),

      // ── Divider ──────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.borderDark : AppColors.borderLight,
        thickness: 0.5,
      ),
    );
  }
}
