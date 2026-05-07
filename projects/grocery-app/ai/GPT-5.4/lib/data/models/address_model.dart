class AddressModel {
  const AddressModel({
    required this.id,
    required this.label,
    required this.addressLine,
    required this.city,
    required this.instructions,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String addressLine;
  final String city;
  final String instructions;
  final bool isDefault;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      label: json['label'] as String,
      addressLine: json['addressLine'] as String,
      city: json['city'] as String,
      instructions: json['instructions'] as String,
      isDefault: json['isDefault'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'addressLine': addressLine,
      'city': city,
      'instructions': instructions,
      'isDefault': isDefault,
    };
  }
}
