import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String url;

  const NewsDetailScreen({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<String>(
        future:
            fetchFullNews(url), // Функция для получения полного текста новости
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text(snapshot.data ?? '', style: TextStyle(fontSize: 16)),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> fetchFullNews(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final contentElement = document
          .querySelector('.news-content'); // Замените на правильный селектор
      return contentElement?.innerHtml ?? 'Содержимое недоступно';
    } else {
      throw Exception('Не удалось загрузить детали новости');
    }
  }
}
