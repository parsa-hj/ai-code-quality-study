class ReviewModel {
  const ReviewModel({
    required this.id,
    required this.author,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final String id;
  final String author;
  final double rating;
  final String comment;
  final String date;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      author: json['author'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: json['date'] as String,
    );
  }
}
