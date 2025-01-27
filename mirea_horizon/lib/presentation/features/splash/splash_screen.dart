import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;
  final spRepository = GetIt.instance<SPRepository>();
  bool isFirst = true;
  String? email = '';

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
    _startSplashScreen();
  }

  Future<void> _checkFirstLaunch() async {
    isFirst = await spRepository.isFirstLaunch();
    // setState(() {
    //   _isFirstLaunch = isFirstLaunch;
    // });
  }

  _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _opacity = 0.0; // Начинаем анимацию исчезновения
    });
    await Future.delayed(
        const Duration(seconds: 1)); // Ждем завершения анимации
    // Здесь вы можете использовать GoRouter для перехода на нужную страницу
    isFirst ? context.go('/intro') : context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/mirea.png'),
              const SizedBox(height: 20),
              const Text(
                'e-Learning Platform',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // const CircularProgressIndicator(),
              const Spacer(),
              Text(
                  'Copyright © ${DateTime.now().year} Technological University',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const Padding(
                  padding: EdgeInsets.all(16.0), // Отступы вокруг текста
                  child: Text('All Right Reserved',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
