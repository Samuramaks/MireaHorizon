// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/test_bloc/test_bloc.dart';
// import '../../bloc/test_bloc/test_state.dart';
// import '../../bloc/test_bloc/test_event.dart';
// import 'test_detail_screen.dart';

// class TestsScreen extends StatelessWidget {
//   const TestsScreen({Key? key}) : super(key: key);

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   context.read<TestBloc>().add(FetchTests()); // Убедитесь, что это вызывается
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Available Tests'),
//       ),
//       body: BlocBuilder<TestBloc, TestState>(
//         builder: (context, state) {
//           print('Current state: $state');
//           print('Loaded tests:');
//           if (state is TestLoading) {
//             print('loading');
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is TestsLoaded) {
//             return ListView.builder(
//               itemCount: state.tests.length,
//               itemBuilder: (context, index) {
//                 final test = state.tests[index];
//                 return ListTile(
//                   title: Text(test.nameTest),
//                   subtitle: Text('Difficulty: ${test.difficultyLevel}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TestDetailScreen(test: test),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else if (state is TestError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           print('[eq]');
//           return const Center(child: Text('No tests'));
//           // return const Center(child: Text('No tests available'));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';

import '../../bloc/test_bloc/test_state.dart';
import 'test_detail_screen.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({Key? key}) : super(key: key);

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<TestBloc>()
        .add(FetchTests()); // Вызываем событие для загрузки тестов
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестирование'),
      ),
      body: BlocBuilder<TestBloc, TestState>(
        builder: (context, state) {
          print('Current state: $state');
          if (state is TestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TestsLoaded) {
            return ListView.builder(
              itemCount: state.tests.length,
              itemBuilder: (context, index) {
                final test = state.tests[index];
                return ListTile(
                  title: Text(test.nameTest),
                  subtitle: Text('Уровень сложности: ${test.difficultyLevel}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestDetailScreen(test: test),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is TestError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Нет доступных тестов'));
        },
      ),
    );
  }
}
