class Result {
  final String email;
  final int coins;
  final String testName;
  final int correctAnswers;
  final int totalQuestions;

  Result({
    required this.email,
    required this.coins,
    required this.testName,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'testName': testName,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
    };
  }

  // Метод для создания объекта из JSON
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      email: json['user']['email'],
      coins: json['user']['coins'],
      testName: json['testName'],
      correctAnswers: json['correctAnswers'],
      totalQuestions: json['totalQuestions'],
    );
  }
}
