import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/repositories/auth_repository.dart';
import 'package:mirea_horizon/main.dart';
import 'package:mirea_horizon/presentation/bloc/auth_bloc/auth_state.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/base/navigation_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _getNameAndEmailBySP();
    _checkEmailVerification();
  }

  void _getNameAndEmailBySP() async {
    setState(() {
      name = user!.displayName ??
          'Имя не указано'; // Устанавливаем значение по умолчанию
      email = user!.email ??
          'Электронная почта не указана'; // Устанавливаем значение по умолчанию
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
    print(user!.emailVerified);
    return CustomWidget(
      nameAppBar: 'Профиль ',
      actions: [
        user!.emailVerified ? const Icon(Icons.verified) : Container(),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.read<AuthBloc>().add(SignOutRequested());
            context.read<NavigationBloc>().add(ResetNavigationEvent());
          },
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const CircularProgressIndicator();
            } else if (state is AuthError) {
              return Text('Ошибка: ${state.error}');
            } else if (state is Authenticated) {
              if (state.user.email == null) {
                return const Text('Вы не авторизованы');
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name),
                    Text(email),
                    user!.emailVerified
                        ? Container()
                        : TextButton(
                            onPressed: () {
                              authRepository.emailVerification();
                              _showDialog(context);
                            },
                            child: const Text('Подтвердите почту'))
                  ],
                ),
              );
            } else {
              return const Text('Вы не авторизованы');
            }
          },
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение почты'),
          content: const Text(
              'Подтверждение отправлено на почту, которая была указана при регистрации'),
          actions: <Widget>[
            TextButton(
              child: Text('Закрыть'),
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
