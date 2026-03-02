// lib/data/services/user_direction_service.dart

import 'package:flutter/foundation.dart';

class UserDirectionService extends ChangeNotifier {
  static final UserDirectionService _instance =
      UserDirectionService._internal();
  factory UserDirectionService() => _instance;
  UserDirectionService._internal();

  String? _selectedDirection;

  String? get selectedDirection => _selectedDirection;

  void setDirection(String? direction) {
    if (_selectedDirection != direction) {
      _selectedDirection = direction;
      notifyListeners();
    }
  }

  void clear() {
    if (_selectedDirection != null) {
      _selectedDirection = null;
      notifyListeners();
    }
  }

  // Метод для проверки, относится ли событие к выбранному направлению
  bool isEventRelevant(String eventType) {
    if (_selectedDirection == null) return true;

    switch (_selectedDirection) {
      case 'Total':
        return true; // Показывать все события

      case 'Programmer':
        // Программирование: Backend, Frontend, Mobile, GameDev
        return ['Backend', 'Frontend', 'Mobile', 'GameDev'].contains(eventType);

      case 'Designer Education':
        // Дизайн: UI/UX
        return ['UI/UX'].contains(eventType);

      case 'Analyst Education':
        // Аналитика: AI, Аналитика, Менеджмент, Инфраструктура
        return ['AI', 'Аналитика', 'Менеджмент', 'Инфраструктура']
            .contains(eventType);

      default:
        return true;
    }
  }
}
