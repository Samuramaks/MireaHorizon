// presentation/widgets/direction_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/tests/direction.dart';
import 'package:mirea_horizon/data/models/tests/test_models.dart';
import 'package:mirea_horizon/presentation/features/widgets/tramslation.dart';

class DirectionCard extends StatefulWidget {
  final Direction direction;

  const DirectionCard({super.key, required this.direction});

  @override
  State<DirectionCard> createState() => _DirectionCardState();
}

class _DirectionCardState extends State<DirectionCard> {
  bool _isExpanded = false;
  List<Test>? _tests;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // 🔹 Заголовок направления (кликабельный)
          ListTile(
            title: Text(
              widget.direction.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: widget.direction.description != null
                ? Text(widget.direction.description!)
                : null,
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              setState(() => _isExpanded = !_isExpanded);
              if (_isExpanded && _tests == null) {
                _loadTests();
              }
            },
          ),

          // 🔹 Раскрывающийся список тестов
          if (_isExpanded)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _tests == null || _tests!.isEmpty
                      ? const Text('Нет доступных тестов',
                          style: TextStyle(color: Colors.grey))
                      : Column(
                          children: _tests!
                              .map((test) => _buildTestTile(test, context))
                              .toList(),
                        ),
            ),
        ],
      ),
    );
  }

  /// Виджет одного теста в списке
  Widget _buildTestTile(Test test, BuildContext context) {
    return ListTile(
      title: Text(
        TestTranslations.getDirectionRu(test.nameTest),
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text(
          'Сложность: ${TestTranslations.getDifficultyRu(test.difficultyLevel)}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => context.go('/app/tests/details', extra: test),
    );
  }

  /// Загрузка тестов для направления
  Future<void> _loadTests() async {
    setState(() => _isLoading = true);
    try {
      // 🔥 Здесь должен быть вызов к репозиторию/BLoC
      // Для примера — заглушка:
      await Future.delayed(const Duration(milliseconds: 500));
      // _tests = await repository.getTestsByDirection(widget.direction.code);
      setState(() => _tests = []); // Заглушка
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки тестов: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
