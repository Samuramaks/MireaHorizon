// lib/presentation/features/widgets/test_translations.dart

class TestTranslations {
  // ==================== НАПРАВЛЕНИЯ ====================
  static const Map<String, String> _directions = {
    'Programmer': 'Программирование',
    'ProgrammerEasy': 'Первоначальный тест',
    'Analyst Education': 'Аналитика',
    'Analyst': 'Аналитика',
    'Designer': 'Дизайн',
    'Designer Education': 'Дизайн',
    'Total': 'Общее',
  };

  // ==================== УРОВНИ СЛОЖНОСТИ ====================
  static const Map<String, String> _difficulties = {
    'Easy': 'Легкий',
    'Normal': 'Средний',
    'Hard': 'Тяжелый',
    'All': 'Все',
    'NoLevel': 'Без уровня',
  };

  // ==================== ПУБЛИЧНЫЕ МЕТОДЫ ====================

  /// Переводит направление из EN → RU
  static String getDirectionRu(String? en) {
    if (en == null) return 'Не указано';
    return _directions[en] ?? en; // Если нет перевода — возвращаем как есть
  }

  /// Переводит сложность из EN → RU
  static String getDifficultyRu(String? en) {
    if (en == null) return 'Не указано';
    return _difficulties[en] ?? en;
  }

  /// Обратный перевод: RU → EN (для отправки на сервер)
  static String getDirectionEn(String? ru) {
    if (ru == null) return 'Total';
    return _directions.entries
        .firstWhere((e) => e.value == ru,
            orElse: () => MapEntry('Total', 'Общее'))
        .key;
  }
}
