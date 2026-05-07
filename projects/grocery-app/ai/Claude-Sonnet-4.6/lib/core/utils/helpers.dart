import 'package:intl/intl.dart';
import 'package:grocery_app/core/constants/app_constants.dart';

/// General-purpose helper functions used across the app.
class Helpers {
  Helpers._();

  // ─── Currency ─────────────────────────────────────────────────────────────

  /// Formats a double as a currency string, e.g. "$12.99".
  static String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      symbol: AppConstants.currencySymbol,
      decimalDigits: 2,
    );
    return formatter.format(price);
  }

  /// Returns "$X.XX OFF" or "X% OFF" label.
  static String discountLabel(int percent) => '$percent% OFF';

  // ─── Date / Time ──────────────────────────────────────────────────────────

  static String formatDate(DateTime date) =>
      DateFormat(AppConstants.dateFormat).format(date);

  static String formatDateTime(DateTime date) =>
      DateFormat(AppConstants.dateTimeFormat).format(date);

  static String formatTime(DateTime date) =>
      DateFormat(AppConstants.timeFormat).format(date);

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return formatDate(date);
  }

  // ─── Greeting ─────────────────────────────────────────────────────────────

  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  // ─── Text ─────────────────────────────────────────────────────────────────

  /// Truncates text to [maxLength] characters with an ellipsis.
  static String truncate(String text, {int maxLength = 50}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}…';
  }

  /// Returns "1 item" or "3 items" based on count.
  static String itemCount(int count) =>
      count == 1 ? '1 item' : '$count items';

  // ─── Numbers ──────────────────────────────────────────────────────────────

  /// Formats a rating to 1 decimal, e.g. 4.5.
  static String formatRating(double rating) => rating.toStringAsFixed(1);

  /// Formats large numbers: 1500 → "1.5K", 1_200_000 → "1.2M".
  static String formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  // ─── Cart ─────────────────────────────────────────────────────────────────

  /// Calculates the discounted price.
  static double discountedPrice(double price, int discountPercent) {
    return price * (1 - discountPercent / 100);
  }
}
