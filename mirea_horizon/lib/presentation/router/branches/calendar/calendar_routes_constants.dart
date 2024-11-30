import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class CalendarRoutes {
  static const base = RouterConst("/calendar");
  static const details = RouterConst("details", base: CalendarRoutes.base);
}
