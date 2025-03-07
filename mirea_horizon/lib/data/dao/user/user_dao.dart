import 'package:mirea_horizon/data/models/user/user_model.dart';

abstract class UserDao {
  Future<void> postUser(UserCustom user);
}
