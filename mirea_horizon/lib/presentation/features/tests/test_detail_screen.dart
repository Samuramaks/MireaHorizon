import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/data/models/test_models.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_state.dart';
import 'test_result_screen.dart';

class TestDetailScreen extends StatefulWidget {
  final Test test;

  const TestDetailScreen({Key? key, required this.test}) : super(key: key);

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

  void submitTest() {
    int score = 0;
    for (int i = 0; i < widget.test.questions.length; i++) {
      if (selectedAnswers[i] == widget.test.questions[i].correctAnswer) {
        score++;
      }
    }

    // Используем Navigator.popUntil для возврата на две страницы назад
    Navigator.popUntil(
        context, (route) => route.isFirst); // Возвращаемся на первую страницу
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestResultScreen(
          score: score,
          totalQuestions: widget.test.questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.nameTest),
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
            onPressed: submitTest,
            child: Text('Отправить тест',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
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
    Key? key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
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
            }).toList(),
          ],
        ),
      ),
    );
  }
}
