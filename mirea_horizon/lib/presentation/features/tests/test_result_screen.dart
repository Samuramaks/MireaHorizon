import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/result/result_model.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';
import 'package:mirea_horizon/data/repositories/result/result_repository.dart';
import 'package:mirea_horizon/presentation/features/tests/test_detail_screen.dart';
import 'package:mirea_horizon/presentation/router/branches/tests/tests_routes_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class TestResultScreen extends StatelessWidget {
  final TestResultArguments testResultArguments;
  final ResultRepository resultRepository = ResultRepository();
  User? user = FirebaseAuth.instance.currentUser!;
  final spRepository = GetIt.instance<SPRepository>();

  TestResultScreen({super.key, required this.testResultArguments});

  List<String> designDirections = [
    'Компьютерный дизайн',
    'Разработка и дизайн компьютерных игр и мультимедийных приложений',
  ];

  List<String> programmingDirections = [
    'Системное программирование и компьютерные технологии',
    'Организация и технологии защиты информации (в сфере связи, информационных и коммуникационных технологий)',
    'Разработка защищенных телекоммуникационных систем',
    'Искусственный интеллект и машинное обучение',
    'Системная и программная инженерия',
    'Технологии разработки программного обеспечения полного цикла',
    'Цифровые комплексы, системы и сети',
    'Разработка кроссплатформенных бизнес-приложений',
  ];

  List<String> analytDirections = [
    "Системное программирование и компьютерные технологии",
    "Технологии информационно-аналитического мониторинга",
    "Интеллектуальные системы управления и обработки информации",
    "Управление ИТ-инфраструктурой организации",
    "Системная и программная инженерия",
    "Математическое моделирование и вычислительная математика",
    "Анализ данных",
    "Промышленная информатика",
    "Управление данными",
    "Разработка кроссплатформенных бизнес-приложений",
    "Информатизация организаций",
    "Инженерия автоматизированных систем",
    "Информационные системы управления ресурсами предприятия",
    "Цифровая трансформация",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Добавляем отступы
        child: Center(
          child: testResultArguments.score == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Вы набрали 0 баллов, пожалуйста повторите попытку'),
                    ElevatedButton(
                      onPressed: () async {
                        // await spRepository.setNewUserFlag(false);
                        context.go(TestsRoutes.base());
                      },
                      child: Text('Вернуться к тесту',
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
                        _buildDirectionInfo(context),
                        ElevatedButton(
                          onPressed: () async {
                            await spRepository.setNewUserFlag(false);
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

Widget _buildDirectionInfo(BuildContext context) {
  List<String> designDirections = [
    'Компьютерный дизайн',
    'Разработка и дизайн компьютерных игр и мультимедийных приложений',
  ];

  List<String> programmingDirections = [
    'Системное программирование и компьютерные технологии',
    'Организация и технологии защиты информации (в сфере связи, информационных и коммуникационных технологий)',
    'Разработка защищенных телекоммуникационных систем',
    'Искусственный интеллект и машинное обучение',
    'Системная и программная инженерия',
    'Технологии разработки программного обеспечения полного цикла',
    'Цифровые комплексы, системы и сети',
    'Разработка кроссплатформенных бизнес-приложений',
  ];

  List<String> analyt = [
    "Системное программирование и компьютерные технологии",
    "Технологии информационно-аналитического мониторинга",
    "Интеллектуальные системы управления и обработки информации",
    "Управление ИТ-инфраструктурой организации",
    "Системная и программная инженерия",
    "Математическое моделирование и вычислительная математика",
    "Анализ данных",
    "Промышленная информатика",
    "Управление данными",
    "Разработка кроссплатформенных бизнес-приложений",
    "Информатизация организаций",
    "Инженерия автоматизированных систем",
    "Информационные системы управления ресурсами предприятия",
    "Цифровая трансформация",
  ];

  Map<String, String> mapDirection = {
    'Аналитик':
        'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=1&eduLocations=1&onlyPartners=false&sorting=',
    'Прогераммист':
        'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=3&eduLocations=1&onlyPartners=false&sorting=',
    'Дизайн':
        'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=7&eduLocations=1&onlyPartners=false&sorting='
  };
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _buildStyledButton(
        context,
        'Аналитик',
        'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=1&eduLocations=1&onlyPartners=false&sorting=',
      ),
      // SizedBox(height: 10),
      _buildStyledButton(
        context,
        'Программист',
        'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=3&eduLocations=1&onlyPartners=false&sorting=',
      ),
      // SizedBox(height: 10),
      _buildStyledButton(
        context,
        'Дизайнер',
        'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=7&eduLocations=1&onlyPartners=false&sorting=',
      ),
      const SizedBox(height: 10),
      const Text(
        'Подробнее можете почитать на сайте Мирэа, нажав на кнопку',
        style: const TextStyle(fontSize: 16),
      ),
      ElevatedButton(
        onPressed: () =>
            _launchInBrowser(Uri.parse('https://priem.mirea.ru/guide')),
        child: Text('Сайт Мирэа',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      ),
    ],
  );
}

Widget _buildStyledButton(BuildContext context, String label, String url) {
  return TextButton(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      // backgroundColor: Colors.blueAccent,
      // primary: Colors.white,
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    onPressed: () => _launchInBrowser(Uri.parse(url)),
    child: Text(label),
  );
}

// void _showDirectionDialog(BuildContext context, String title) {
//   List<String> selectedDirections;
//   if (title == 'Дизайн') {
//     selectedDirections = designDirections;
//   } else if (title == 'Прогер') {
//     selectedDirections = programmingDirections;
//   } else if (title == 'Аналитик') {
//     // Пример для другого title
//     selectedDirections = analytDirections;
//   } else {
//     selectedDirections = []; // Пустой массив, если title не совпадает
//   }
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         backgroundColor: Colors.white,
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: selectedDirections
//                 .map((direction) => Text('• $direction'))
//                 .toList(),
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Закрыть'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
