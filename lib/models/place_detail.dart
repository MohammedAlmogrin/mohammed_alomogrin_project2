class PlaceDetail {
  final int pageId;
  final String title;
  final String extract;
  final String? thumbnail;

  PlaceDetail({
    required this.pageId,
    required this.title,
    required this.extract,
    this.thumbnail,
  });

  factory PlaceDetail.fromJson(Map<String, dynamic> json) {
    return PlaceDetail(
      pageId: json['pageid'] ?? json['pageId'] ?? 0,
      title: json['title'] ?? '',
      extract: (json['extract'] != null && json['extract'].toString().trim().isNotEmpty)
          ? json['extract'].toString()
          : 'Discover the deep historical roots and rich heritage of this iconic landmark.',
      thumbnail: json['thumbnail'] is Map ? json['thumbnail']['source'] : json['thumbnail']?.toString(),
    );
  }
}