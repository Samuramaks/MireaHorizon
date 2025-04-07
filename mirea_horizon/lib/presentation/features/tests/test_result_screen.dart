import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/result/result_model.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';
import 'package:mirea_horizon/data/repositories/result/result_repository.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';
import 'package:mirea_horizon/presentation/features/tests/test_detail_screen.dart';
import 'package:mirea_horizon/presentation/features/widgets/utils.dart';
import 'package:mirea_horizon/presentation/router/branches/tests/tests_routes_constants.dart';

import '../../bloc/test_bloc/test_bloc.dart';

// ignore: must_be_immutable
class TestResultScreen extends StatelessWidget {
  final TestResultArguments testResultArguments;
  final ResultRepository resultRepository = ResultRepository();
  User? user = FirebaseAuth.instance.currentUser!;
  final spRepository = GetIt.instance<SPRepository>();

  TestResultScreen({super.key, required this.testResultArguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Добавляем отступы
        child: Center(
          child: testResultArguments.score == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                        'Вы набрали 0 баллов, пожалуйста повторите попытку'),
                    ElevatedButton(
                      onPressed: () async {
                        context.go(TestsRoutes.base());
                      },
                      child: Text('Вернуться к тестам',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface)),
                    ),
                  ],
                )
              : testResultArguments.level == 'NoLevel'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: testResultArguments.programmingScore
                                      .toDouble(),
                                  color: Colors.greenAccent,
                                  title: 'Прогер',
                                  radius: 60,
                                ),
                                PieChartSectionData(
                                  value: testResultArguments.designScore
                                      .toDouble(),
                                  color: Colors.purpleAccent,
                                  title: 'Дизайн',
                                  radius: 60,
                                ),
                                PieChartSectionData(
                                  value: testResultArguments.analytScore
                                      .toDouble(),
                                  color: Colors.yellowAccent,
                                  title: 'Аналитик',
                                  radius: 60,
                                ),
                              ],
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyUtils.buildDirectionInfo(context),
                        ElevatedButton(
                          onPressed: () async {
                            await spRepository.setNewUserFlag(false);
                            context.read<TestBloc>().add(FetchTests());
                            context.go(TestsRoutes.base());
                          },
                          child: Text('Вернуться к тестам',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Правильные ответы: ${testResultArguments.score} / ${testResultArguments.totalQuestions}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await resultRepository.submitTestResult(Result(
                              email: user!.email!,
                              coins: testResultArguments.score,
                              testName: testResultArguments.nameTest,
                              correctAnswers: testResultArguments.score,
                              totalQuestions:
                                  testResultArguments.totalQuestions,
                            ));
                            context.go(TestsRoutes.base());
                          },
                          child: Text('Вернуться к тестам',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
