import 'package:flutter/material.dart';

import '../../core/utils/app_formatters.dart';

class PriceBreakdownCard extends StatelessWidget {
  const PriceBreakdownCard({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.deliveryFee,
    required this.total,
  });

  final double subtotal;
  final double discount;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget row(String label, String value, {bool bold = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Text(label),
            const Spacer(),
            Text(
              value,
              style: bold
                  ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)
                  : theme.textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            row('Subtotal', AppFormatters.currency(subtotal)),
            row('Discount', '-${AppFormatters.currency(discount)}'),
            row('Delivery', AppFormatters.currency(deliveryFee)),
            const Divider(height: 28),
            row('Total', AppFormatters.currency(total), bold: true),
          ],
        ),
      ),
    );
  }
}
