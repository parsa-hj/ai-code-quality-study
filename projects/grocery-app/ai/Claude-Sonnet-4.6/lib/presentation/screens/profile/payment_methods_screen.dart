import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/app_export.dart';

/// Payment methods screen (mock — no real payment integration).
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  final List<Map<String, dynamic>> _methods = const [
    {
      'name': 'Visa •••• 4242',
      'type': 'visa',
      'isDefault': true,
    },
    {
      'name': 'Mastercard •••• 8765',
      'type': 'mastercard',
      'isDefault': false,
    },
    {
      'name': 'Cash on Delivery',
      'type': 'cash',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.paymentMethods),
        actions: [
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment addition coming soon!'),
                  backgroundColor: AppColors.info,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text(AppStrings.add),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        separatorBuilder: (_, __) =>
            const SizedBox(height: AppSizes.spacingMD),
        itemCount: _methods.length,
        itemBuilder: (_, i) => _MethodTile(method: _methods[i]),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final Map<String, dynamic> method;
  const _MethodTile({required this.method});

  @override
  Widget build(BuildContext context) {
    final isDefault = method['isDefault'] as bool;
    final type = method['type'] as String;

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: isDefault
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            child: Icon(
              type == 'cash' ? Icons.money : Icons.credit_card,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method['name'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (isDefault)
                  const Text(
                    'Default',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          if (!isDefault)
            TextButton(
              onPressed: () {},
              child: const Text('Set Default'),
            ),
        ],
      ),
    );
  }
}
