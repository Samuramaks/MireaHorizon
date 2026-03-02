class Direction {
  final int id;
  final String name; // "02.03.02 Искусственный интеллект..."
  final String code; // "ai_ml_02_03_02" — для API
  final String? description;
  final int instituteId;
  final String? instituteName;

  Direction({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.instituteId,
    this.instituteName,
  });

  factory Direction.fromJson(Map<String, dynamic> json) {
    return Direction(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      instituteId: json['instituteId'] ?? json['institute']?['id'] ?? 1,
      instituteName: json['instituteName'] ?? json['institute']?['name'],
    );
  }
}
