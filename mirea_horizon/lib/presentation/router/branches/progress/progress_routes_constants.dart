import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class ProgressRoutes {
  static const base = RouterConst("/progress");
  static const details = RouterConst("details", base: ProgressRoutes.base);
}
