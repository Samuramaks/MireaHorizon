class Event {
  final String name;
  final DateTime date;
  final String description;
  final Uri? url;

  Event({
    required this.name,
    required this.date,
    required this.description,
    this.url,
  });

  // Метод для создания объекта из JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      date: DateTime.parse(json['date']), // Преобразуем строку в DateTime
      description: json['description'],
      url: json['url'] != null
          ? Uri.parse(json['url'])
          : null, // Если URL есть, парсим его
    );
  }

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(), // Преобразуем DateTime в строку
      'description': description,
      'url': url?.toString(), // Преобразуем Uri в строку, если URL есть
    };
  }
}
