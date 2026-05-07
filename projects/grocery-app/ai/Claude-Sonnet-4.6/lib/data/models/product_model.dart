/// A selectable product variant (e.g., size, weight, pack size).
class ProductVariant {
  final String id;
  final String label; // "500g", "1kg", "6-pack"
  final double? extraCost; // additional price on top of base

  const ProductVariant({
    required this.id,
    required this.label,
    this.extraCost,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] as String,
      label: json['label'] as String,
      extraCost: (json['extraCost'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'extraCost': extraCost,
      };
}

/// Full product data model.
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice; // null when not on sale
  final int discountPercent; // 0 when not on sale
  final String categoryId;
  final String categoryName;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final String unit; // "kg", "each", "pack", "dozen", etc.
  final List<ProductVariant> variants;
  final List<String> tags;
  final bool isPopular;
  final bool isRecommended;
  final bool isFlashDeal;
  final bool isOrganic;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    this.discountPercent = 0,
    required this.categoryId,
    required this.categoryName,
    required this.images,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inStock = true,
    this.unit = 'each',
    this.variants = const [],
    this.tags = const [],
    this.isPopular = false,
    this.isRecommended = false,
    this.isFlashDeal = false,
    this.isOrganic = false,
  });

  /// The effective selling price (after discount).
  double get effectivePrice =>
      discountPercent > 0 ? price * (1 - discountPercent / 100) : price;

  bool get isOnSale => discountPercent > 0 || originalPrice != null;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      discountPercent: (json['discountPercent'] as int?) ?? 0,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      images: List<String>.from(json['images'] as List),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as int?) ?? 0,
      inStock: (json['inStock'] as bool?) ?? true,
      unit: (json['unit'] as String?) ?? 'each',
      variants: (json['variants'] as List<dynamic>?)
              ?.map((v) => ProductVariant.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      tags: List<String>.from((json['tags'] as List<dynamic>?) ?? []),
      isPopular: (json['isPopular'] as bool?) ?? false,
      isRecommended: (json['isRecommended'] as bool?) ?? false,
      isFlashDeal: (json['isFlashDeal'] as bool?) ?? false,
      isOrganic: (json['isOrganic'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'originalPrice': originalPrice,
        'discountPercent': discountPercent,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'images': images,
        'rating': rating,
        'reviewCount': reviewCount,
        'inStock': inStock,
        'unit': unit,
        'variants': variants.map((v) => v.toJson()).toList(),
        'tags': tags,
        'isPopular': isPopular,
        'isRecommended': isRecommended,
        'isFlashDeal': isFlashDeal,
        'isOrganic': isOrganic,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ProductModel && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
