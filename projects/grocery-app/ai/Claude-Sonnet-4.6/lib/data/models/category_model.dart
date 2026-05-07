import 'package:flutter/material.dart';

/// A product category shown on the home and categories screens.
class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final Color color; // background tint for the category card
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    this.productCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      color: Color(json['color'] as int),
      productCount: (json['productCount'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'color': color.value,
        'productCount': productCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CategoryModel && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
