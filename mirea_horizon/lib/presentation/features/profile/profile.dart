import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/data/repositories/auth_repository.dart';
import 'package:mirea_horizon/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:mirea_horizon/presentation/bloc/base/navigation_bloc.dart';
import 'package:mirea_horizon/presentation/features/widgets/utils.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/test_bloc/test_bloc.dart';
import '../../bloc/test_bloc/test_event.dart';
import '../widgets/custom_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String name = '';
  String email = '';
  User? user = FirebaseAuth.instance.currentUser!;
  AuthRepository authRepository = GetIt.instance<AuthRepository>();

  // Переменная для хранения выбранного направления
  String? selectedDirection;
  final Map<String, String> testDirections = {
    'Общее': 'Total',
    'Программирование': 'Programmer',
    'Дизайн': 'Designer Education',
    'Аналитика': 'Analyst Education',
  };

  @override
  void initState() {
    super.initState();
    _getNameAndEmailBySP();
    _checkEmailVerification();
  }

  void _getNameAndEmailBySP() async {
    setState(() {
      name = user!.displayName ?? 'Имя не указано';
      email = user!.email ?? 'Электронная почта не указана';
    });
  }

  Future<void> _checkEmailVerification() async {
    if (user != null) {
      await user!.reload();
      user = FirebaseAuth.instance.currentUser!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return CustomWidget(
      nameAppBar: 'Профиль',
      actions: [
        user!.emailVerified
            ? Icon(
                Icons.verified,
                color: colorScheme.onSurface,
              )
            : Container(),
      ],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Информация о пользователе
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            if (!user!.emailVerified)
              ElevatedButton(
                onPressed: () {
                  authRepository.emailVerification();
                  _showDialog(context);
                },
                child: const Text('Подтвердить почту'),
              ),
            const SizedBox(height: 20),
            // Кнопки направлений
            MyUtils.buildDirectionInfo(context),

            const SizedBox(height: 20),

            // Выпадающий список для выбора направления
            const Text(
              'Выберите направление:',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              value: selectedDirection,
              hint: const Text('Выберите направление'),
              items: testDirections.keys.map((String direction) {
                return DropdownMenuItem<String>(
                  value: direction,
                  child: Text(direction),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDirection = newValue;

                  print('SelectedDirect: ${testDirections[selectedDirection]}');
                  context.read<TestBloc>().add(FetchTestForDirection(
                      testDirections[selectedDirection]!));
                });
              },
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
                context.read<NavigationBloc>().add(ResetNavigationEvent());
              },
              child: const Text(
                'Выйти из профиля',
                style: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Подтверждение почты'),
          content: const Text(
              'Подтверждение отправлено на почту, которая была указана при регистрации'),
          actions: <Widget>[
            TextButton(
              child: const Text('Закрыть'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
          ],
        );
      },
    );
  }
}
