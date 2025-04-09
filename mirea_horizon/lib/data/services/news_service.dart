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
        final titleElement = element.querySelector('.achiv-title');
        final title = titleElement?.text.trim();

        // Извлекаем ссылку на новость
        final linkElement =
            element.querySelector('a'); // Находим первый <a> внутри элемента
        final link = linkElement?.attributes['href'];

        // Извлекаем дату
        final dateElement = element.querySelector('.date-wrapper');
        final date = dateElement?.text.trim() ?? '';

        // Извлекаем URL изображения
        final imageElement = element.querySelector('.smi_abs__img');
        final imageUrl = imageElement?.attributes['data-src'] ?? '';

        // print('https://www.mirea.ru$imageUrl');

        return NewsItem(
          title: title ?? '',
          date: date,
          imageUrl: 'https://www.mirea.ru$imageUrl',
          link: linkElement != null ? 'https://mirea.ru$link' : '',
          description: '', // Добавьте, если нужно
        );
      }).toList();

      return newsList;
    } else {
      throw Exception('Не удалось загрузить новости');
    }
  }
}
