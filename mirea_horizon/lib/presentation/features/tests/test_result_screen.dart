// import 'package:flutter/material.dart';

// class TestResultScreen extends StatelessWidget {
//   final int score;
//   final int totalQuestions;

//   const TestResultScreen(
//       {Key? key, required this.score, required this.totalQuestions})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Results'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Your Score: $score / $totalQuestions',
//                 style: Theme.of(context).textTheme.headlineMedium),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Вернуться к списку тестов
//               },
//               child: const Text('Back to Tests'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TestResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const TestResultScreen(
      {Key? key, required this.score, required this.totalQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Правильные ответы: $score / $totalQuestions',
                style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Вернуться к списку тестов
              },
              child: Text('Вернуться к тестам',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface)),
            ),
          ],
        ),
      ),
    );
  }
}
