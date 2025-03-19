import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/tests/test_models.dart';
import 'package:mirea_horizon/data/repositories/user_repository/user_repository.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';
import '../../../data/repositories/local_data/sp_repository.dart';
import '../../bloc/test_bloc/test_state.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final UserRepository userRepository = UserRepository();
  int coins = 0;
  User? user = FirebaseAuth.instance.currentUser!;
  final spRepository = GetIt.instance<SPRepository>();
  @override
  void initState() {
    super.initState();
    _checkForNewUser();

    // context.read<TestBloc>().add(FetchTests());
    _updateCoins();
  }

  void _checkForNewUser() async {
    await _isNewUser()
        ? context.read<TestBloc>().add(FetchTestForNewUser())
        : context.read<TestBloc>().add(FetchTests());
  }

  Future<void> _updateCoins() async {
    if (user != null) {
      int updatedCoins = await userRepository.getUserCoins(user!.email!) as int;
      setState(() {
        coins = updatedCoins;
      });
    }
  }

  Future<void> _refreshData(BuildContext context) async {
    _updateCoins();
    BlocProvider.of<TestBloc>(context).add(RefreshTests());
  }

  Future<bool> _isNewUser() async {
    return await spRepository.isNewUser(); // Проверяем, новый ли пользователь
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text('$coins'),
          Image.asset(
            'assets/images/coin.png',
            width: 23,
            height: 23,
          ),
          const Spacer(),
          const Text('Тестирование'),
          const Spacer(),
        ],
      )),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        backgroundColor: Colors.white,
        child: BlocBuilder<TestBloc, TestState>(
          builder: (context, state) {
            if (state is TestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TestsLoaded) {
              return ListView.builder(
                itemCount: state.tests.length,
                itemBuilder: (context, index) {
                  final test = state.tests[index];
                  return Card(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        context.go('/app/tests/details', extra: test);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              test.nameTest,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Уровень сложности: ${test.difficultyLevel}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Количество вопросов: ${test.questions.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TestError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Нет доступных тестов'));
          },
        ),
      ),
    );
  }
}
