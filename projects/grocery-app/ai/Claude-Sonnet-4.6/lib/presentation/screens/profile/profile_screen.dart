import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/profile_controller.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// User profile screen.
class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        child: Column(
          children: [
            // ── User Card ──────────────────────────────────────────────
            Obx(
              () => _UserCard(
                name: controller.currentUser.value?.name ?? '',
                email: controller.currentUser.value?.email ?? '',
                avatarUrl: controller.currentUser.value?.avatarUrl,
                onEdit: () => _showEditDialog(context),
              ),
            ),

            const SizedBox(height: AppSizes.spacingLG),

            // ── Menu ───────────────────────────────────────────────────
            _MenuTile(
              icon: Icons.location_on_outlined,
              title: AppStrings.myAddresses,
              onTap: () => Get.toNamed(AppRoutes.addresses),
            ),
            _MenuTile(
              icon: Icons.favorite_outline,
              title: AppStrings.wishlist,
              onTap: () => Get.toNamed(AppRoutes.wishlist),
            ),
            _MenuTile(
              icon: Icons.receipt_long_outlined,
              title: AppStrings.myOrders,
              onTap: () => Get.toNamed(AppRoutes.orders),
            ),
            _MenuTile(
              icon: Icons.notifications_outlined,
              title: AppStrings.notifications,
              onTap: () => Get.toNamed(AppRoutes.notifications),
            ),

            const Divider(height: AppSizes.spacingXXL),

            // ── Dark mode toggle ───────────────────────────────────────
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.dark_mode_outlined,
                  color: AppColors.primary),
              title: const Text(AppStrings.darkMode),
              trailing: Switch(
                value: Get.isDarkMode,
                onChanged: (v) => Get.changeThemeMode(
                    v ? ThemeMode.dark : ThemeMode.light),
                activeColor: AppColors.primary,
              ),
            ),

            const Divider(height: AppSizes.spacingLG),

            // ── Logout ─────────────────────────────────────────────────
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text(AppStrings.logout,
                  style: TextStyle(color: AppColors.error)),
              onTap: () => _confirmLogout(context),
            ),

            const SizedBox(height: AppSizes.spacingXXL),
            Text(
              '${AppStrings.appName} v1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textDisabled,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final nameCtrl = TextEditingController(
        text: controller.currentUser.value?.name);
    final phoneCtrl = TextEditingController(
        text: controller.currentUser.value?.phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXXL)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: AppSizes.paddingXL,
          left: AppSizes.paddingXXL,
          right: AppSizes.paddingXXL,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              AppSizes.paddingXXL,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.editProfile,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSizes.spacingXL),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                  labelText: AppStrings.fullName,
                  prefixIcon: Icon(Icons.person_outline)),
            ),
            const SizedBox(height: AppSizes.spacingLG),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  labelText: AppStrings.phone,
                  prefixIcon: Icon(Icons.phone_outlined)),
            ),
            const SizedBox(height: AppSizes.spacingXXL),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : () {
                        controller.updateProfile(
                          name: nameCtrl.text,
                          phone: phoneCtrl.text.isEmpty
                              ? null
                              : phoneCtrl.text,
                        );
                        Get.back();
                      },
                child: const Text(AppStrings.saveChanges),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.logout),
        content: const Text(AppStrings.logoutConfirm),
        actions: [
          TextButton(onPressed: Get.back, child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: const Text(AppStrings.logout,
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

// ─── User Card ────────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;
  final VoidCallback onEdit;

  const _UserCard({
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white.withOpacity(0.3),
            backgroundImage:
                avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.fontLG,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: AppSizes.fontSM,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuTile(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
