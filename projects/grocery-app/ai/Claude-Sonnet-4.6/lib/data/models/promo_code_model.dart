/// A discount promo code that users can apply at checkout.
class PromoCodeModel {
  final String code;
  final String description;
  final double discountPercent; // e.g. 10 = 10%
  final double? maxDiscountAmount; // cap on the discount
  final double? minimumOrderAmount; // min subtotal required
  final DateTime? expiresAt;
  final bool isActive;

  const PromoCodeModel({
    required this.code,
    required this.description,
    required this.discountPercent,
    this.maxDiscountAmount,
    this.minimumOrderAmount,
    this.expiresAt,
    this.isActive = true,
  });

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  bool get isValid => isActive && !isExpired;

  /// Calculates the discount amount for a given subtotal.
  double calculateDiscount(double subtotal) {
    if (!isValid) return 0;
    if (minimumOrderAmount != null && subtotal < minimumOrderAmount!) return 0;
    final discount = subtotal * discountPercent / 100;
    if (maxDiscountAmount != null && discount > maxDiscountAmount!) {
      return maxDiscountAmount!;
    }
    return discount;
  }

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      code: json['code'] as String,
      description: json['description'] as String,
      discountPercent: (json['discountPercent'] as num).toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble(),
      minimumOrderAmount: (json['minimumOrderAmount'] as num?)?.toDouble(),
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
      isActive: (json['isActive'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'description': description,
        'discountPercent': discountPercent,
        'maxDiscountAmount': maxDiscountAmount,
        'minimumOrderAmount': minimumOrderAmount,
        'expiresAt': expiresAt?.toIso8601String(),
        'isActive': isActive,
      };
}
