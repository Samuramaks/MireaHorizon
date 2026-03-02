class UserCustom {
  final int? id;
  final String email;
  final int? coins;
  final String? avatarUrl; // Новое поле

  UserCustom({
    this.id,
    required this.email,
    this.coins,
    this.avatarUrl,
  });

  factory UserCustom.fromJson(Map<String, dynamic> json) {
    return UserCustom(
      id: json['id'],
      email: json['email'],
      coins: json['coins'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'coins': coins,
      'avatarUrl': avatarUrl,
    };
  }
}
