class PaymentMethodModel {
  const PaymentMethodModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.isDefault,
  });

  final String id;
  final String title;
  final String subtitle;
  final String type;
  final bool isDefault;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      type: json['type'] as String,
      isDefault: json['isDefault'] as bool,
    );
  }
}
