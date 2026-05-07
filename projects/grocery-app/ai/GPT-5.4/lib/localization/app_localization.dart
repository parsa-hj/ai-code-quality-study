import 'package:get/get.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'app_name': 'FreshCart',
          'welcome_back': 'Welcome back',
          'discover': 'Discover fresh groceries',
          'shop_now': 'Shop now',
          'login': 'Login',
          'signup': 'Sign up',
          'forgot_password': 'Forgot password?',
          'checkout': 'Checkout',
          'cart': 'Cart',
          'orders': 'Orders',
          'profile': 'Profile',
          'favorites': 'Favorites',
        },
      };
}
