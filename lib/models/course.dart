class Course {
  final String id;
  final String title;
  final String description;
  final double price;
  final double star;
  final int reviewsCount;
  final String typeId;
  final bool isInterest;
  final String? imageUrl;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.star,
    required this.reviewsCount,
    required this.typeId,
    this.isInterest = false,
    this.imageUrl,
  });

  Course copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? star,
    int? reviewsCount,
    String? typeId,
    bool? isInterest,
    String? imageUrl,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      star: star ?? this.star,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      typeId: typeId ?? this.typeId,
      isInterest: isInterest ?? this.isInterest,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
