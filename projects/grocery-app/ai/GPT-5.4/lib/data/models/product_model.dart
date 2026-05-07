import 'review_model.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imageUrl,
    required this.gallery,
    required this.price,
    required this.originalPrice,
    required this.unit,
    required this.description,
    required this.variants,
    required this.rating,
    required this.reviewCount,
    required this.isPopular,
    required this.isRecommended,
    required this.discountTag,
    required this.reviews,
  });

  final String id;
  final String name;
  final String categoryId;
  final String imageUrl;
  final List<String> gallery;
  final double price;
  final double originalPrice;
  final String unit;
  final String description;
  final List<String> variants;
  final double rating;
  final int reviewCount;
  final bool isPopular;
  final bool isRecommended;
  final String discountTag;
  final List<ReviewModel> reviews;

  bool get hasDiscount => originalPrice > price;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      gallery: (json['gallery'] as List<dynamic>).cast<String>(),
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      unit: json['unit'] as String,
      description: json['description'] as String,
      variants: (json['variants'] as List<dynamic>).cast<String>(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isPopular: json['isPopular'] as bool,
      isRecommended: json['isRecommended'] as bool,
      discountTag: json['discountTag'] as String,
      reviews: (json['reviews'] as List<dynamic>)
          .map((item) => ReviewModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
