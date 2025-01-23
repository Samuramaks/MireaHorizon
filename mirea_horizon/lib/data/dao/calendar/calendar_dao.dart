import '../../models/calendar/calendar_model.dart';

abstract class CalendarDAO {
  Future<List<Event>> fetchCalendar();

  Future<List<Event>> getCalendarByParameter(String param);
}
