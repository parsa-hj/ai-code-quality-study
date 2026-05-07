import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/controllers/profile_controller.dart';
import 'package:grocery_app/data/models/address_model.dart';

/// Addresses management screen.
class AddressesScreen extends GetView<ProfileController> {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myAddresses),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAddressSheet(context),
          ),
        ],
      ),
      body: Obx(
        () => controller.addresses.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_off_outlined,
                        size: 72, color: AppColors.grey300),
                    const SizedBox(height: 16),
                    Text(AppStrings.noAddresses,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _showAddAddressSheet(context),
                      icon: const Icon(Icons.add),
                      label: const Text(AppStrings.addAddress),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.paddingLG),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSizes.spacingMD),
                itemCount: controller.addresses.length,
                itemBuilder: (_, i) =>
                    _AddressTile(address: controller.addresses[i]),
              ),
      ),
      floatingActionButton: Obx(
        () => controller.addresses.isNotEmpty
            ? FloatingActionButton(
                onPressed: () => _showAddAddressSheet(context),
                child: const Icon(Icons.add),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  void _showAddAddressSheet(BuildContext context) {
    final labelCtrl = TextEditingController(text: 'Home');
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final line1Ctrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final postalCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
          bottom:
              MediaQuery.of(context).viewInsets.bottom + AppSizes.paddingXXL,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppStrings.addAddress,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSizes.spacingXL),
                _Field(ctrl: labelCtrl, label: 'Label (e.g. Home, Work)'),
                _Field(ctrl: nameCtrl, label: AppStrings.fullName, validator: Validators.name),
                _Field(ctrl: phoneCtrl, label: AppStrings.phone, validator: Validators.phone),
                _Field(ctrl: line1Ctrl, label: AppStrings.addressLine1, validator: Validators.required),
                _Field(ctrl: cityCtrl, label: AppStrings.city, validator: Validators.required),
                _Field(ctrl: stateCtrl, label: AppStrings.state, validator: Validators.required),
                _Field(ctrl: postalCtrl, label: AppStrings.postalCode, validator: Validators.required),
                const SizedBox(height: AppSizes.spacingXXL),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.addAddress(
                                label: labelCtrl.text,
                                name: nameCtrl.text,
                                phone: phoneCtrl.text,
                                line1: line1Ctrl.text,
                                city: cityCtrl.text,
                                state: stateCtrl.text,
                                postalCode: postalCtrl.text,
                              );
                            }
                          },
                    child: controller.isSaving.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Text(AppStrings.saveAddress),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final FormFieldValidator<String>? validator;

  const _Field({required this.ctrl, required this.label, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingMD),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label),
        validator: validator,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  final AddressModel address;
  const _AddressTile({required this.address});

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<ProfileController>();

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: address.isDefault
            ? Border.all(color: AppColors.primary, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  address.label,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Default',
                    style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
              ],
              const Spacer(),
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'default') {
                    profile.setDefaultAddress(address.id);
                  } else if (v == 'delete') {
                    profile.deleteAddress(address.id);
                  }
                },
                itemBuilder: (_) => [
                  if (!address.isDefault)
                    const PopupMenuItem(
                        value: 'default',
                        child: Text(AppStrings.setAsDefault)),
                  const PopupMenuItem(
                      value: 'delete',
                      child: Text(AppStrings.delete,
                          style: TextStyle(color: AppColors.error))),
                ],
                child: const Icon(Icons.more_vert, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(address.recipientName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          Text(address.phone,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(address.fullAddress,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
