import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class MainRoutes {
  static const base = RouterConst("/main");
  static const details = RouterConst("details", base: MainRoutes.base);
}
