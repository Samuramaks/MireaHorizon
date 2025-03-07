import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class ProfileRoutes {
  static const base = RouterConst("/app/profile");
  static const settings = RouterConst("settings", base: ProfileRoutes.base);
}
