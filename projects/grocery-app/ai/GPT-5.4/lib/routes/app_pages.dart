import 'package:get/get.dart';

import '../presentation/screens/auth/forgot_password_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/cart_screen.dart';
import '../presentation/screens/checkout_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/order_detail_screen.dart';
import '../presentation/screens/order_success_screen.dart';
import '../presentation/screens/orders_screen.dart';
import '../presentation/screens/product_details_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../presentation/screens/tracking_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.product, page: () => const ProductDetailsScreen()),
    GetPage(name: AppRoutes.cart, page: () => const CartScreen()),
    GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => const OrderSuccessScreen(),
    ),
    GetPage(name: AppRoutes.orders, page: () => const OrdersScreen()),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailScreen(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.tracking, page: () => const TrackingScreen()),
  ];
}
