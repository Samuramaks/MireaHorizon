import 'dart:convert';

import 'package:mirea_horizon/data/dao/calendar/calendar_dao.dart';
import 'package:mirea_horizon/data/models/calendar/calendar_model.dart';
import 'package:http/http.dart' as http;

class CalendarService implements CalendarDAO {
  final String apiUrl = 'http://127.0.0.1:8080/api/calendar';

  @override
  Future<List<Event>> fetchCalendar() async {
    try {
      print("Respone: r");
      final response = await http.get(Uri.parse(apiUrl));
      print("Respone: ${response}");
      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load calendar');
      }
    } catch (e) {
      throw Exception('Error fetching calendar: $e');
    }
  }

  //TODO: сделать как дойду до профиля
  @override
  Future<List<Event>> getCalendarByParameter(String param) {
    // TODO: implement getCalendarByParameter
    throw UnimplementedError();
  }
}
