import 'package:flutter/material.dart';
import 'package:mirea_horizon/presentation/features/main/news_list_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const NewsListWidget(); // Отображаем экран новостей сразу
  }
}
