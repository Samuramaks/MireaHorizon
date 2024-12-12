import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import '../models/news_item.dart';

class NewsService {
  Future<List<NewsItem>> fetchNews() async {
    final response = await http.get(Uri.parse('https://mirea.ru/news/'));

    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final newsItems = document.querySelectorAll('.uk-margin-top.slider_body');

      List<NewsItem> newsList = newsItems.map((element) {
        final titleElement = element.querySelector('.uk-link-reset');
        final linkElement = titleElement?.attributes['href'];
        final title = titleElement?.text.trim();
        final dateElement =
            element.querySelector('.news-date'); // Добавьте, если нужно
        final date = dateElement?.text.trim() ?? ''; // Добавьте, если нужно
        final imageElement =
            element.querySelector('img'); // Добавьте, если нужно
        final imageUrl =
            imageElement?.attributes['src'] ?? ''; // Добавьте, если нужно

        return NewsItem(
          title: title ?? '',
          date: date,
          imageUrl: imageUrl,
          link: linkElement != null ? 'https://mirea.ru$linkElement' : '',
          description: '', // Добавьте, если нужно
        );
      }).toList();

      return newsList;
    } else {
      throw Exception('Не удалось загрузить новости');
    }
  }
}
