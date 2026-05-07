import 'package:flutter/material.dart';

/// Centralized color palette for the GroceryGo app.
/// All colors used throughout the app are defined here.
class AppColors {
  AppColors._();

  // ─── Primary (Fresh Green) ────────────────────────────────────────────────
  static const Color primary = Color(0xFF2ECC71);
  static const Color primaryDark = Color(0xFF27AE60);
  static const Color primaryLight = Color(0xFFD5F5E3);
  static const Color primarySurface = Color(0xFFF0FBF4);

  // ─── Secondary (Vibrant Orange) ───────────────────────────────────────────
  static const Color secondary = Color(0xFFFF6B35);
  static const Color secondaryDark = Color(0xFFE55A24);
  static const Color secondaryLight = Color(0xFFFFEDE6);

  // ─── Backgrounds ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color cardDark = Color(0xFF2D3748);

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB5BD);
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);

  // ─── Status ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // ─── Grey Scale ───────────────────────────────────────────────────────────
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // ─── Special ──────────────────────────────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF424242);
  static const Color shimmerHighlightDark = Color(0xFF616161);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color dividerDark = Color(0xFF374151);
  static const Color overlay = Color(0x80000000);
  static const Color transparent = Colors.transparent;

  // ─── Badges & Labels ──────────────────────────────────────────────────────
  static const Color starFilled = Color(0xFFFFC107);
  static const Color starEmpty = Color(0xFFE5E7EB);
  static const Color discount = Color(0xFFEF4444);
  static const Color newBadge = Color(0xFF3B82F6);
  static const Color organicBadge = Color(0xFF2ECC71);

  // ─── Dark Mode Surfaces ───────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkCard = Color(0xFF374151);
}
