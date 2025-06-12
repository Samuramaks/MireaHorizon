import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class ProfileRoutes {
  static const base = RouterConst("/app/profile");
  static const settings = RouterConst("settings", base: ProfileRoutes.base);
  static const change_passw =
      RouterConst("changePass", base: ProfileRoutes.settings);
  static const info_app = RouterConst("info", base: ProfileRoutes.base);
}
