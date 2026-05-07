import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/cart_controller.dart';
import 'package:grocery_app/presentation/screens/home/home_screen.dart';
import 'package:grocery_app/presentation/screens/search/search_screen.dart';
import 'package:grocery_app/presentation/screens/cart/cart_screen.dart';
import 'package:grocery_app/presentation/screens/orders/orders_screen.dart';
import 'package:grocery_app/presentation/screens/profile/profile_screen.dart';

/// Root screen with bottom navigation bar.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: selectedIndex.value,
          children: _pages,
        ),
        bottomNavigationBar: _BottomNav(
          selectedIndex: selectedIndex.value,
          onTap: (i) => selectedIndex.value = i,
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final isDark = context.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizes.bottomNavHeight,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: AppStrings.navHome,
                index: 0,
                selectedIndex: selectedIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: AppStrings.navSearch,
                index: 1,
                selectedIndex: selectedIndex,
                onTap: onTap,
              ),
              // Cart with badge
              Expanded(
                child: InkWell(
                  onTap: () => onTap(2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            selectedIndex == 2
                                ? Icons.shopping_cart
                                : Icons.shopping_cart_outlined,
                            color: selectedIndex == 2
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          Obx(
                            () => cart.totalQuantity > 0
                                ? Positioned(
                                    right: -6,
                                    top: -6,
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        color: AppColors.error,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                          minWidth: 16, minHeight: 16),
                                      child: Text(
                                        cart.totalQuantity > 99
                                            ? '99+'
                                            : '${cart.totalQuantity}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.navCart,
                        style: TextStyle(
                          fontSize: 10,
                          color: selectedIndex == 2
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontWeight: selectedIndex == 2
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _NavItem(
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: AppStrings.navOrders,
                index: 3,
                selectedIndex: selectedIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: AppStrings.navProfile,
                index: 4,
                selectedIndex: selectedIndex,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


