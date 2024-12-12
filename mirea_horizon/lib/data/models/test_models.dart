class Test {
  final int id;
  final String nameTest;
  final String difficultyLevel;
  final List<Question> questions;

  Test({
    required this.id,
    required this.nameTest,
    required this.difficultyLevel,
    required this.questions,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      nameTest: json['nameTest'],
      difficultyLevel: json['difficultyLevel'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      answers: List<String>.from(json['answers']),
      correctAnswer: json['correctAnswer'],
    );
  }
}
