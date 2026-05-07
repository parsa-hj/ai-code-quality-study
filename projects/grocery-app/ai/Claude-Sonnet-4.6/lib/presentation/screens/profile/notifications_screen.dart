import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/profile_controller.dart';

/// Notification preferences screen.
class NotificationsScreen extends GetView<ProfileController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.notifications),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        children: [
          Text(
            AppStrings.pushNotifications,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          Obx(
            () => _Toggle(
              title: AppStrings.orderUpdates,
              subtitle: AppStrings.orderUpdatesDesc,
              value: controller.orderUpdates.value,
              onChanged: controller.toggleOrderUpdates,
            ),
          ),
          Obx(
            () => _Toggle(
              title: AppStrings.promotionsLabel,
              subtitle: AppStrings.promotionsDesc,
              value: controller.promotions.value,
              onChanged: controller.togglePromotions,
            ),
          ),
          Obx(
            () => _Toggle(
              title: AppStrings.remindersLabel,
              subtitle: AppStrings.remindersDesc,
              value: controller.reminders.value,
              onChanged: controller.toggleReminders,
            ),
          ),
          const Divider(height: AppSizes.spacingXXL),
          Text(
            AppStrings.contactNotifications,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          Obx(
            () => _Toggle(
              title: AppStrings.emailNotificationsLabel,
              subtitle: AppStrings.emailNotificationsDesc,
              value: controller.emailNotifications.value,
              onChanged: controller.toggleEmailNotifications,
            ),
          ),
          Obx(
            () => _Toggle(
              title: AppStrings.smsNotificationsLabel,
              subtitle: AppStrings.smsNotificationsDesc,
              value: controller.smsNotifications.value,
              onChanged: controller.toggleSmsNotifications,
            ),
          ),
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _Toggle({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}
