class PlaceIteme {
  final int pageId;
  final String title;
  final String? thumbnail;

  PlaceIteme({
    required this.pageId,
    required this.title,
    this.thumbnail,
  });

  factory PlaceIteme.fromJson(Map<String, dynamic> json) {
    return PlaceIteme(
      pageId: json['pageid'] ?? json['pageId'] ?? 0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] is Map ? json['thumbnail']['source'] : json['thumbnail']?.toString(),
    );
  }
}