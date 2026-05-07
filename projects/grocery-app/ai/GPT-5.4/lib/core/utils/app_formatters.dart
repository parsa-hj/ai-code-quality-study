import 'package:flutter/material.dart';

class AppFormatters {
  static String currency(double value) => '\$${value.toStringAsFixed(2)}';

  static Color colorFromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static IconData iconFromKey(String key) {
    switch (key) {
      case 'eco':
        return Icons.eco_outlined;
      case 'apple':
        return Icons.apple_outlined;
      case 'water_drop':
        return Icons.water_drop_outlined;
      case 'bakery_dining':
        return Icons.bakery_dining_outlined;
      case 'cookie':
        return Icons.cookie_outlined;
      case 'local_cafe':
        return Icons.local_cafe_outlined;
      default:
        return Icons.shopping_bag_outlined;
    }
  }
}
