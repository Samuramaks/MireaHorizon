class Event {
  final String name;
  final DateTime date;
  final String description;
  final String url;
  final String? imageUrl;

  Event({
    required this.name,
    required this.date,
    required this.description,
    required this.url,
    this.imageUrl,
  });

  // Метод для создания объекта из JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        name: json['name'],
        date: DateTime.parse(json['date']), // Преобразуем строку в DateTime
        description: json['description'],
        url: json['url'], // Если URL есть, парсим его
        imageUrl: json['imageUrl']);
  }

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(), // Преобразуем DateTime в строку
      'description': description,
      'url': url, // Преобразуем Uri в строку, если URL есть
      'imageUrl': imageUrl,
    };
  }
}
