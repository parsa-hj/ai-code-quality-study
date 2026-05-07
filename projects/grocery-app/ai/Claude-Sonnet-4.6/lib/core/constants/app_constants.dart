/// General application constants — storage keys, API config, thresholds, etc.
class AppConstants {
  AppConstants._();

  // ─── App ──────────────────────────────────────────────────────────────────
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // ─── SharedPreferences Keys ───────────────────────────────────────────────
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyAuthToken = 'auth_token';
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyCartData = 'cart_data';
  static const String keyWishlistData = 'wishlist_data';
  static const String keySearchHistory = 'search_history';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyOrderUpdates = 'order_updates';
  static const String keyPromotions = 'promotions';
  static const String keyReminders = 'reminders';
  static const String keyEmailNotifications = 'email_notifications';
  static const String keySmsNotifications = 'sms_notifications';

  // ─── API ──────────────────────────────────────────────────────────────────
  static const String baseUrl = 'https://api.grocerygo.com/v1';
  static const int connectionTimeout = 30000; // ms
  static const int receiveTimeout = 30000; // ms

  // ─── Pagination ───────────────────────────────────────────────────────────
  static const int defaultPageSize = 20;
  static const int maxSearchHistory = 10;
  static const int maxSearchResults = 50;

  // ─── Cart ─────────────────────────────────────────────────────────────────
  static const int maxItemQuantity = 99;
  static const double freeDeliveryThreshold = 50.0;
  static const double standardDeliveryFee = 4.99;
  static const double expressDeliveryFee = 9.99;
  static const double scheduledDeliveryFee = 2.99;

  // ─── Animation Durations (ms) ─────────────────────────────────────────────
  static const int shortAnimDuration = 200;
  static const int mediumAnimDuration = 300;
  static const int longAnimDuration = 500;
  static const int splashDuration = 2500;
  static const int bannerAutoPlayInterval = 4000;

  // ─── Currency ─────────────────────────────────────────────────────────────
  static const String currencySymbol = '\$';
  static const String currencyCode = 'USD';

  // ─── Date Formats ─────────────────────────────────────────────────────────
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy • hh:mm a';
  static const String dayMonthFormat = 'dd MMM';

  // ─── Mock Auth ────────────────────────────────────────────────────────────
  // Demo credentials for testing
  static const String demoEmail = 'demo@grocerygo.com';
  static const String demoPassword = 'demo1234';
}
