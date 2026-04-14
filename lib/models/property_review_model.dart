class PropertyReviewModel {
  const PropertyReviewModel({
    required this.authorName,
    required this.rating,
    required this.comment,
    required this.timeLabel,
  });

  final String authorName;
  final int rating;
  final String comment;
  final String timeLabel;
}
