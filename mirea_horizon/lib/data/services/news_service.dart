import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import '../models/news/news_item.dart';

class NewsService {
  Future<List<NewsItem>> fetchNews() async {
    final response = await http.get(Uri.parse('https://mirea.ru/news/'));

    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final newsItems = document.querySelectorAll('.uk-card.uk-card-default');

      List<NewsItem> newsList = newsItems.map((element) {
        final titleElement = element.querySelector('.uk-link-reset');
        final linkElement = titleElement?.attributes['href'];
        final title = titleElement?.text.trim();

        // Извлекаем дату
        final dateElement =
            element.querySelector('.uk-margin-small-bottom.uk-text-small');
        final date = dateElement?.text.trim() ?? '';

        // Извлекаем URL изображения
        final imageElement = element.querySelector('.uk-card-media-top img');
        final imageUrl = imageElement?.attributes['data-src'] ?? '';

        // print('https://www.mirea.ru$imageUrl');

        return NewsItem(
          title: title ?? '',
          date: date,
          imageUrl: 'https://www.mirea.ru$imageUrl',
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
