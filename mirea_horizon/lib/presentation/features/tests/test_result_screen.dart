import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/result/result_model.dart';
import 'package:mirea_horizon/data/repositories/result/result_repository.dart';
import 'package:mirea_horizon/presentation/features/tests/test_detail_screen.dart';
import 'package:mirea_horizon/presentation/router/branches/tests/tests_routes_constants.dart';

class TestResultScreen extends StatelessWidget {
  final TestResultArguments testResultArguments;
  final ResultRepository resultRepository = ResultRepository();
  User? user = FirebaseAuth.instance.currentUser!;

  TestResultScreen({super.key, required this.testResultArguments});

  @override
  Widget build(BuildContext context) {
    print(user!.email);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Правильные ответы: ${testResultArguments.score} / ${testResultArguments.totalQuestions}',
                style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () async {
                context.go(TestsRoutes.base());
                await resultRepository.submitTestResult(Result(
                    email: user!.email!,
                    coins: testResultArguments.score,
                    testName: testResultArguments.nameTest,
                    correctAnswers: testResultArguments.score,
                    totalQuestions: testResultArguments.totalQuestions));
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
