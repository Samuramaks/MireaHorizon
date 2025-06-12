import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import '../models/news/news_item.dart';

class NewsService {
  Future<List<NewsItem>> fetchNews() async {
    final response = await http.get(Uri.parse('https://mirea.ru/news/'));

    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final newsItems =
          document.querySelectorAll('.news-block-slider-grid__item');

      List<NewsItem> newsList = newsItems.map((element) {
        final titleElement = element.querySelector('.events-block-body');
        final title = titleElement?.text.trim();

        // Извлекаем ссылку на новость
        final linkElement = element.attributes['href'] ?? '';
        final link = linkElement.isNotEmpty ? linkElement : '';

        // Извлекаем дату
        final newsBlockContent = element.querySelector('.news-block-content');
        final date = newsBlockContent?.nodes
                .lastWhere((node) => node.text?.trim().isNotEmpty ?? false)
                .text
                ?.trim() ??
            '';

        // Извлекаем URL изображения
        final imageElement = element.querySelector('.uk-card-media-top img');
        final imageUrl = imageElement?.attributes['src'] ??
            imageElement?.attributes['data-src'];

        print(imageUrl);

        return NewsItem(
          title: title ?? '',
          date: date,
          imageUrl: 'https://www.mirea.ru$imageUrl',
          link: linkElement != null ? 'https://mirea.ru$link' : '',
          description: '', // Добавьте, если нужно
        );
      }).toList();

      print('News: ${newsList}');

      return newsList;
    } else {
      throw Exception('Не удалось загрузить новости');
    }
  }
}
