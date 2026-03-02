import 'package:flutter/foundation.dart';

class UserAvatarService extends ChangeNotifier {
  static final UserAvatarService _instance = UserAvatarService._internal();
  factory UserAvatarService() => _instance;
  UserAvatarService._internal();

  String? _avatarUrl;

  String? get avatarUrl => _avatarUrl;

  void setAvatar(String? url) {
    _avatarUrl = url;
    notifyListeners();
  }

  void clearAvatar() {
    _avatarUrl = null;
    notifyListeners();
  }
}
