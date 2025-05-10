class Article {
  final int id;
  final String title;
  final String body;
  final bool isFavorite;

  Article({
    required this.id,
    required this.title,
    required this.body,
    this.isFavorite = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Article copyWith({bool? isFavorite}) {
    return Article(
      id: id,
      title: title,
      body: body,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
