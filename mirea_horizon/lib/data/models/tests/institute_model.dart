class Institute {
  final int id;
  final String name;
  final String? description;
  final String? instituteName;

  Institute({
    required this.id,
    required this.name,
    this.description,
    this.instituteName,
  });

  factory Institute.fromJson(Map<String, dynamic> json) {
    return Institute(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      instituteName: json['instituteName'] ?? json['institute']?['name'],
    );
  }
}
