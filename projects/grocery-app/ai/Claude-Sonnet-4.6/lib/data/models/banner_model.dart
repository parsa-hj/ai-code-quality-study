/// A promotional banner shown in the home screen carousel.
class BannerModel {
  final String id;
  final String imageUrl;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final String? actionRoute; // GetX route name
  final String? actionArgument; // e.g., category id

  const BannerModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.actionRoute,
    this.actionArgument,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      actionLabel: json['actionLabel'] as String?,
      actionRoute: json['actionRoute'] as String?,
      actionArgument: json['actionArgument'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'subtitle': subtitle,
        'actionLabel': actionLabel,
        'actionRoute': actionRoute,
        'actionArgument': actionArgument,
      };
}
