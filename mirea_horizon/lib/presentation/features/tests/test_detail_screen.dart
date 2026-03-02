import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/tests/test_models.dart';
import 'package:mirea_horizon/presentation/features/widgets/tramslation.dart';

class TestDetailScreen extends StatefulWidget {
  final Test test;

  const TestDetailScreen({super.key, required this.test});

  @override
  _TestDetailScreenState createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  List<String?> selectedAnswers = [];
  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.test.questions.length,
        null); // Инициализируем список выбранных ответов
  }

  String? _extractAnswerLetter(String? fullAnswer) {
    if (fullAnswer == null) return null;
    // Ожидаем формат: "A) Текст ответа" или "B. Текст"
    final match = RegExp(r'^([A-D])[).]').firstMatch(fullAnswer);
    return match?.group(1);
  }

  void submitTest() {
    int programmingScore = 0;
    int designScore = 0;
    int analytScore = 0;
    int score = 0;
    if (widget.test.difficultyLevel == 'NoLevel') {
      for (int i = 0; i < widget.test.questions.length; i++) {
        if (selectedAnswers[i] == widget.test.questions[i].correctAnswer) {
          if (i < 3) {
            programmingScore++; // Первые 3 вопроса - программирование
          } else if (i < 6) {
            designScore++; // Следующие 3 вопроса - дизайн
          } else {
            analytScore++; // Последние 4 вопроса - системное администрирование
          }
        }
      }
      score = programmingScore + designScore + analytScore;
    } else {
      for (int i = 0; i < widget.test.questions.length; i++) {
        final selectedLetter = _extractAnswerLetter(selectedAnswers[i]);
        final correctAnswer = widget.test.questions[i].correctAnswer;
        // print(
        //     'Q$i: Выбрано: "${selectedAnswers[i]}", Правильный ответ: "${widget.test.questions[i].correctAnswer}"');
        // print(
        //     '   Типы: selected=${selectedAnswers[i]?.runtimeType}, correct=${widget.test.questions[i].correctAnswer?.runtimeType}');
        if (selectedLetter == correctAnswer) {
          score++;
        }
      }
    }
    final test = widget.test;
    final args = TestResultArguments(
      score: score,
      coins: score,
      totalQuestions: test.questions.length,
      nameTest: test.nameTest,
      level: test.difficultyLevel,
      designScore: designScore,
      programmingScore: programmingScore,
      analytScore: analytScore,
    );
    context.go('/app/tests/result', extra: args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TestTranslations.getDirectionRu(widget.test.nameTest),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.test.questions.length,
              itemBuilder: (context, index) {
                final question = widget.test.questions[index];
                return QuestionCard(
                  question: question,
                  selectedAnswer: selectedAnswers[index],
                  onAnswerSelected: (answer) {
                    setState(() {
                      selectedAnswers[index] =
                          answer; // Сохраняем выбранный ответ
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                elevation: 2),
            onPressed: submitTest,
            child: const Text(
              'Отправить тест',
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Question question;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Theme.of(context).colorScheme.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.question),
            const SizedBox(height: 8),
            ...question.answers.map((answer) {
              return RadioListTile(
                title: Text(answer),
                value: answer,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  onAnswerSelected(
                      answer); // Вызываем функцию при выборе ответа
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class TestResultArguments {
  final int score;
  final int coins;
  final int totalQuestions;
  final String nameTest;
  final int programmingScore;
  final int designScore;
  final int analytScore;
  final String level;

  TestResultArguments({
    required this.score,
    required this.coins,
    required this.totalQuestions,
    required this.nameTest,
    required this.level,
    this.designScore = 0,
    this.programmingScore = 0,
    this.analytScore = 0,
  });
}
