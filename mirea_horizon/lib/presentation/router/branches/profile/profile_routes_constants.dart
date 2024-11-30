import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class ProfileRoutes {
  static const base = RouterConst("/profile");
  static const details = RouterConst("details", base: ProfileRoutes.base);
}
