import 'package:get/get.dart';
import 'package:grocery_app/presentation/bindings/auth_binding.dart';
import 'package:grocery_app/presentation/bindings/cart_binding.dart';
import 'package:grocery_app/presentation/bindings/home_binding.dart';
import 'package:grocery_app/presentation/bindings/order_binding.dart';
import 'package:grocery_app/presentation/bindings/product_binding.dart';
import 'package:grocery_app/presentation/bindings/profile_binding.dart';
import 'package:grocery_app/presentation/screens/auth/forgot_password_screen.dart';
import 'package:grocery_app/presentation/screens/auth/login_screen.dart';
import 'package:grocery_app/presentation/screens/auth/signup_screen.dart';
import 'package:grocery_app/presentation/screens/cart/cart_screen.dart';
import 'package:grocery_app/presentation/screens/category/category_products_screen.dart';
import 'package:grocery_app/presentation/screens/checkout/checkout_screen.dart';
import 'package:grocery_app/presentation/screens/checkout/order_success_screen.dart';
import 'package:grocery_app/presentation/screens/main/main_screen.dart';
import 'package:grocery_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:grocery_app/presentation/screens/orders/order_detail_screen.dart';
import 'package:grocery_app/presentation/screens/orders/order_tracking_screen.dart';
import 'package:grocery_app/presentation/screens/orders/orders_screen.dart';
import 'package:grocery_app/presentation/screens/product/product_detail_screen.dart';
import 'package:grocery_app/presentation/screens/profile/addresses_screen.dart';
import 'package:grocery_app/presentation/screens/profile/notifications_screen.dart';
import 'package:grocery_app/presentation/screens/profile/payment_methods_screen.dart';
import 'package:grocery_app/presentation/screens/search/search_screen.dart';
import 'package:grocery_app/presentation/screens/splash/splash_screen.dart';
import 'package:grocery_app/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Defines all GetPage routes with their bindings.
class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    // ─── Splash ───────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),

    // ─── Onboarding ───────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
    ),

    // ─── Auth ─────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // ─── Main Shell ───────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    // ─── Product Detail ───────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailScreen(),
      binding: ProductBinding(),
      transition: Transition.rightToLeft,
    ),

    // ─── Cart ─────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),

    // ─── Checkout ─────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => const OrderSuccessScreen(),
      transition: Transition.zoom,
    ),

    // ─── Orders ───────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderTracking,
      page: () => const OrderTrackingScreen(),
      transition: Transition.rightToLeft,
    ),

    // ─── Search ───────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      transition: Transition.fadeIn,
    ),

    // ─── Categories ───────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.categoryProducts,
      page: () => const CategoryProductsScreen(),
      transition: Transition.rightToLeft,
    ),

    // ─── Wishlist ─────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistScreen(),
      transition: Transition.rightToLeft,
    ),

    // ─── Profile Sub-pages ────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddressesScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.paymentMethods,
      page: () => const PaymentMethodsScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
