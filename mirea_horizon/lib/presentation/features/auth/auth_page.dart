import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/data/models/user/user_model.dart';
import 'package:mirea_horizon/data/repositories/user_repository/user_repository.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../widgets/custom_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final spRepository = GetIt.instance<SPRepository>();
  final UserRepository userRepository = UserRepository();
  bool _isLogin = true;

  @override
  void dispose() {
    _nameController.dispose(); // Освобождаем контроллер имени
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        context.read<AuthBloc>().add(
              SignInRequested(
                _emailController.text.trim(),
                _passwordController.text.trim(),
              ),
            );
      } else {
        context.read<AuthBloc>().add(
              SignUpRequested(
                _emailController.text.trim(),
                _passwordController.text.trim(),
                _nameController.text.trim(),
              ),
            );
        userRepository
            .postUser(UserCustom(email: _emailController.text.trim()));
      }
    }
  }

  // _onGetNameAndEmailBySP() async {
  //   // Проверяем, существует ли уже электронная почта
  //   String? existingEmail = await spRepository.getEmail();
  //   if (existingEmail == null || existingEmail.isEmpty) {
  //     await spRepository.setEmail(_emailController.text.trim());
  //   }

  //   // Проверяем, существует ли уже имя пользователя
  //   String? existingUsername = await spRepository.getUsername();
  //   if (existingUsername == null || existingUsername.isEmpty) {
  //     await spRepository.setUsername(_nameController.text.trim());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: _isLogin ? 'Авторизация' : 'Регистрация',
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            print('Showing error: ${state.error}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_isLogin) ...[
                        // Показываем поле имени только при регистрации
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Имя',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите имя';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Электронная почта',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите электронную почту';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите пароль';
                          }
                          if (value.length < 3) {
                            return 'Пароль должен содержать минимум 3 символов';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(_isLogin ? 'Войти' : 'Зарегистрироваться',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Нет аккаунта? Зарегистрироваться'
                              : 'Уже есть аккаунт? Войти',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                      TextButton(
                          onPressed: () =>
                              context.read<AuthBloc>().add(SignInAsGuest()),
                          child: Text('Войти как гость',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
