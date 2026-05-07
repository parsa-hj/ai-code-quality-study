import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_page_shell.dart';
import '../controllers/profile_controller.dart';
import '../widgets/app_network_image.dart';
import '../widgets/app_button.dart';
import '../widgets/info_tile.dart';
import '../widgets/skeleton_box.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageShell(
      title: 'Profile',
      child: Obx(() {
        final profile = controller.profile.value;
        if (controller.isLoading.value || profile == null) {
          return ListView(
            children: const [
              SkeletonBox(height: 140, radius: 28),
              SizedBox(height: 12),
              SkeletonBox(height: 90),
              SizedBox(height: 12),
              SkeletonBox(height: 90),
            ],
          );
        }

        return ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    AppNetworkImage(
                      imageUrl: profile.avatarUrl,
                      height: 82,
                      width: 82,
                      borderRadius: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.name,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 6),
                          Text(profile.email),
                          const SizedBox(height: 4),
                          Text(profile.phone),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text('Saved addresses', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            ...controller.addresses.map(
              (address) => InfoTile(
                icon: Icons.location_on_outlined,
                title: address.label,
                subtitle: '${address.addressLine}\n${address.city}',
              ),
            ),
            const SizedBox(height: 18),
            Text('Payment methods', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            ...controller.paymentMethods.map(
              (payment) => InfoTile(
                icon: Icons.credit_card_outlined,
                title: payment.title,
                subtitle: payment.subtitle,
              ),
            ),
            const SizedBox(height: 18),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                    title: const Text('Notifications'),
                    subtitle: const Text('Deals, reorder reminders, and delivery updates'),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    value: controller.isDarkMode,
                    onChanged: controller.toggleTheme,
                    title: const Text('Dark mode'),
                    subtitle: const Text('Use a darker appearance across the app'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AppButton(
              label: 'Logout',
              icon: Icons.logout,
              onPressed: controller.logout,
            ),
          ],
        );
      }),
    );
  }
}
