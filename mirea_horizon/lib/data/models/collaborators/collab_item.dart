class Direction {
  final String title;
  final String direction;
  final String description;
  final String imageUrl;
  final String url;

  Direction({
    required this.title,
    required this.direction,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  factory Direction.fromMap(Map<String, String> map) {
    return Direction(
      title: map['title'] ?? 'Название не найдено',
      direction: map['direction'] ?? 'Направление не найдено',
      description: map['description'] ?? 'Описание не найдено',
      imageUrl: map['image_url'] ?? 'Изображение не найдено',
      url: map['url'] ?? 'Ссылка не найдена',
    );
  }
}
