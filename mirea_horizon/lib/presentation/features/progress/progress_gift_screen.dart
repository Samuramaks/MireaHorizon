import 'dart:async';
import 'dart:math';

import 'package:mirea_horizon/presentation/bloc/theme_bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';

class ProgressGiftScreen extends StatefulWidget {
  const ProgressGiftScreen({super.key});

  @override
  State<ProgressGiftScreen> createState() => _ProgressGiftScreenState();
}

class _ProgressGiftScreenState extends State<ProgressGiftScreen> {
  int total = 60;
  int progress = 0;
  @override
  void initState() {
    super.initState();
    // Запускаем анимацию хлопушек при загрузке экрана
    _startConfetti();
  }

  double randomInRange(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  void _startConfetti() {
    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      progress++;

      if (progress >= total) {
        timer.cancel();
        return;
      }

      int count = ((1 - progress / total) * 50).toInt();

      Confetti.launch(
        context,
        options: ConfettiOptions(
            particleCount: count,
            startVelocity: 30,
            spread: 360,
            ticks: 60,
            x: randomInRange(0.1, 0.3),
            y: Random().nextDouble() - 0.2),
      );
      Confetti.launch(
        context,
        options: ConfettiOptions(
            particleCount: count,
            startVelocity: 30,
            spread: 360,
            ticks: 60,
            x: randomInRange(0.7, 0.9),
            y: Random().nextDouble() - 0.2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Подарки',
      body: Center(
        child: Text(
          'Поздравляю, вы выйграли секретную вещь с кафедры университета РТУ МИРЭА!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                // color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
