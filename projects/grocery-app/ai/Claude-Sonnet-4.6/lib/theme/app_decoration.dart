import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/constants/app_sizes.dart';

/// Reusable BoxDecoration and BoxShadow definitions.
class AppDecoration {
  AppDecoration._();

  // ─── Shadows ──────────────────────────────────────────────────────────────

  static List<BoxShadow> get shadowSM => [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMD => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLG => [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  // ─── Card Decorations ─────────────────────────────────────────────────────

  static BoxDecoration get card => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        boxShadow: shadowSM,
      );

  static BoxDecoration cardDark(BuildContext context) => BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.cardDark
            : AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        boxShadow: shadowSM,
      );

  static BoxDecoration get outlineCard => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: AppColors.grey200, width: AppSizes.borderMD),
      );

  // ─── Input Decorations ────────────────────────────────────────────────────

  static BoxDecoration get searchBar => BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      );

  // ─── Banner Gradient ──────────────────────────────────────────────────────

  static BoxDecoration get bannerGradient => BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
      );

  // ─── Primary Gradient Button ──────────────────────────────────────────────

  static BoxDecoration get primaryGradient => BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );

  // ─── Category Badge ───────────────────────────────────────────────────────

  static BoxDecoration categoryBadge(Color color) => BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
      );

  // ─── Discount Badge ───────────────────────────────────────────────────────

  static BoxDecoration get discountBadge => BoxDecoration(
        color: AppColors.discount,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppSizes.radiusLG),
          bottomLeft: Radius.circular(AppSizes.radiusSM),
        ),
      );
}
