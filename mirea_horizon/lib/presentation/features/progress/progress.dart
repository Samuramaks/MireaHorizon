import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/data/repositories/result/result_repository.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_event.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_state.dart';
import '../widgets/custom_widget.dart';

class ProgressScreen extends StatelessWidget {
  final ResultRepository resultRepository = ResultRepository();
  final User? user = FirebaseAuth.instance.currentUser;

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
          child: BlocBuilder<ProgressBloc, ProgressState>(
            builder: (context, state) {
              if (state is ProgressLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProgressError) {
                return ListView(children: [
                  Center(
                    child: Text('Error: ${state.message}'),
                  ),
                ]);
              } else if (state is ProgressLoaded) {
                final testResults = state.result;
                if (testResults.isEmpty) {
                  return ListView(children: const [
                    Center(
                      child: Column(
                        children: [
                          Text('Нет результатов тестов.'),
                        ],
                      ),
                    ),
                  ]);
                }
                return ListView.builder(
                  itemCount: testResults.length,
                  itemBuilder: (context, index) {
                    final testResult = testResults[index];
                    return ScoreCard(
                      testName: testResult.testName,
                      correctAnswers: testResult.correctAnswers,
                      totalQuestions: testResult.totalQuestions,
                    );
                  },
                );
              }
              return const Center(
                child: Text('Нет результатов тестов.'),
              );
            },
          ),
        ));
  }
}

class ScoreCard extends StatelessWidget {
  final String testName;
  final int correctAnswers;
  final int totalQuestions;

  const ScoreCard({
    super.key,
    required this.testName,
    required this.correctAnswers,
    required this.totalQuestions,
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
          Text(
            testName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            width: 20,
          ),
          Text(
            '$correctAnswers / $totalQuestions',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
