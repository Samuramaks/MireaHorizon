// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mirea_horizon/data/repositories/result/result_repository.dart';
// import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_bloc.dart';
// import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_event.dart';
// import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_state.dart';
// import '../widgets/custom_widget.dart';

// class ProgressScreen extends StatelessWidget {
//   final ResultRepository resultRepository = ResultRepository();
//   final User? user = FirebaseAuth.instance.currentUser;

//   ProgressScreen({super.key});

//   Future<void> _refreshData(BuildContext context) async {
//     BlocProvider.of<ProgressBloc>(context).add(RefreshProgress());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomWidget(
//         nameAppBar: 'Успеваемость',
//         body: RefreshIndicator(
//           backgroundColor: Colors.white,
//           onRefresh: () => _refreshData(context),
//           child: BlocBuilder<ProgressBloc, ProgressState>(
//             builder: (context, state) {
//               if (state is ProgressLoading) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (state is ProgressError) {
//                 return ListView(children: [
//                   Center(
//                     child: Text('Error: ${state.message}'),
//                   ),
//                 ]);
//               } else if (state is ProgressLoaded) {
//                 final testResults = state.result;
//                 if (testResults.isEmpty) {
//                   return ListView(children: const [
//                     Center(
//                       child: Column(
//                         children: [
//                           Text('Нет результатов тестов.'),
//                         ],
//                       ),
//                     ),
//                   ]);
//                 }
//                 return ListView.builder(
//                   itemCount: testResults.length,
//                   itemBuilder: (context, index) {
//                     final testResult = testResults[index];
//                     return ScoreCard(
//                       testName: testResult.testName,
//                       correctAnswers: testResult.correctAnswers,
//                       totalQuestions: testResult.totalQuestions,
//                     );
//                   },
//                 );
//               }
//               return const Center(
//                 child: Text('Нет результатов тестов.'),
//               );
//             },
//           ),
//         ));
//   }
// }

// class ScoreCard extends StatelessWidget {
//   final String testName;
//   final int correctAnswers;
//   final int totalQuestions;

//   const ScoreCard({
//     super.key,
//     required this.testName,
//     required this.correctAnswers,
//     required this.totalQuestions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 8.0,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             testName,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const VerticalDivider(
//             color: Colors.grey,
//             thickness: 1,
//             width: 20,
//           ),
//           Text(
//             '$correctAnswers / $totalQuestions',
//             style: const TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/data/models/result/result_model.dart';
import 'package:mirea_horizon/data/repositories/result/result_repository.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_event.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_state.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/widgets/tramslation.dart';
import '../widgets/custom_widget.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';
import 'package:get_it/get_it.dart';

class ProgressScreen extends StatelessWidget {
  final ResultRepository resultRepository = ResultRepository();
  final User? user = FirebaseAuth.instance.currentUser;
  final SPRepository spRepository = GetIt.instance<SPRepository>();
  static const int requiredCoins =
      5; // Минимальное количество монет для кнопки "Получить"

  ProgressScreen({super.key});

  Future<void> _refreshData(BuildContext context) async {
    BlocProvider.of<ProgressBloc>(context).add(RefreshProgress());
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Успеваемость',
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () => _refreshData(context),
        child: FutureBuilder<int>(
          future: spRepository.getTotalCoins(),
          builder: (context, snapshot) {
            // final totalCoins = snapshot.data ?? 0;
            return Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(
                //     'Всего монет: $totalCoins',
                //     style: const TextStyle(
                //         fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                Expanded(
                  child: BlocBuilder<ProgressBloc, ProgressState>(
                    builder: (context, state) {
                      if (state is ProgressLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProgressError) {
                        return ListView(
                          children: [
                            Center(child: Text('Error: ${state.message}')),
                          ],
                        );
                      } else if (state is ProgressLoaded) {
                        final testResults = state.result;
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: spRepository.getTestResults(),
                          builder: (context, cacheSnapshot) {
                            if (!cacheSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final cacheResults = cacheSnapshot.data ?? [];
                            // Объединяем результаты с бэка и кэша, избегая дубликатов
                            final allResults = [
                              ...testResults,
                              ...cacheResults.map((e) => Result(
                                    email: user?.email ?? '',
                                    testName: e['test_name'],
                                    coins: e['coins'],
                                    correctAnswers: e['correct_answers'],
                                    totalQuestions: e['total_questions'],
                                  )),
                            ].asMap().entries.fold<List<Result>>([],
                                (uniqueResults, entry) {
                              if (!uniqueResults.any(
                                  (r) => r.testName == entry.value.testName)) {
                                uniqueResults.add(entry.value);
                              }
                              return uniqueResults;
                            });
                            if (allResults.isEmpty) {
                              return ListView(
                                children: const [
                                  Center(
                                      child: Text('Нет результатов тестов.')),
                                ],
                              );
                            }
                            return ListView.builder(
                              itemCount: allResults.length,
                              itemBuilder: (context, index) {
                                final testResult = allResults[index];
                                return ScoreCard(
                                  testName: TestTranslations.getDirectionRu(
                                      testResult.testName),
                                  correctAnswers: testResult.correctAnswers,
                                  totalQuestions: testResult.totalQuestions,
                                  coins: testResult.coins,
                                  requiredCoins: requiredCoins,
                                  onClaimPressed: () {
                                    context.go(
                                        '/app/progress/details'); // Замени на нужный маршрут
                                  },
                                );
                              },
                            );
                          },
                        );
                      }
                      return const Center(
                          child: Text('Нет результатов тестов.'));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String testName;
  final int correctAnswers;
  final int totalQuestions;
  final int coins;
  final int requiredCoins;
  final VoidCallback onClaimPressed;

  const ScoreCard({
    super.key,
    required this.testName,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.coins,
    required this.requiredCoins,
    required this.onClaimPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  testName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   'Монеты: $coins',
                //   style: const TextStyle(fontSize: 16),
                // ),
                Text(
                  '$correctAnswers / $totalQuestions',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          if (coins >= requiredCoins)
            ElevatedButton(
              onPressed: onClaimPressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              child: const Text('Получить'),
            ),
        ],
      ),
    );
  }
}
