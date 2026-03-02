// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as html;
// import '../models/news/news_item.dart';

// class NewsService {
//   Future<List<NewsItem>> fetchNews() async {
//     final response = await http.get(Uri.parse('https://mirea.ru/news/'));

//     if (response.statusCode == 200) {
//       final document = html.parse(response.body);
//       final newsItems =
//           document.querySelectorAll('.news-block-slider-grid__item');

//       List<NewsItem> newsList = newsItems.map((element) {
//         final titleElement = element.querySelector('.events-block-body');
//         final title = titleElement?.text.trim();

//         // Извлекаем ссылку на новость
//         final linkElement = element.attributes['href'] ?? '';
//         final link = linkElement.isNotEmpty ? linkElement : '';

//         // Извлекаем дату
//         final newsBlockContent = element.querySelector('.news-block-content');
//         final date = newsBlockContent?.nodes
//                 .lastWhere((node) => node.text?.trim().isNotEmpty ?? false)
//                 .text
//                 ?.trim() ??
//             '';

//         // Извлекаем URL изображения
//         final imageElement = element.querySelector('.uk-card-media-top img');
//         final imageUrl = imageElement?.attributes['src'] ??
//             imageElement?.attributes['data-src'];

//         print(imageUrl);

//         return NewsItem(
//           title: title ?? '',
//           date: date,
//           imageUrl: 'https://www.mirea.ru$imageUrl',
//           link: linkElement != null ? 'https://mirea.ru$link' : '',
//           description: '', // Добавьте, если нужно
//         );
//       }).toList();

//       print('News: ${newsList}');

//       return newsList;
//     } else {
//       throw Exception('Не удалось загрузить новости');
//     }
//   }
// }

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import '../models/news/news_item.dart';

// Конфигурация для разных разделов (чтобы не передавать кучу параметров каждый раз)
class SectionConfig {
  final String url;
  final String itemSelector;
  final String titleSelector;
  final String linkSelector; // Селектор для тега <a>
  final String dateSelector;
  final String imageSelector;

  SectionConfig({
    required this.url,
    this.itemSelector = '.news-block-slider-grid__item',
    this.titleSelector = '.events-block-body',
    this.linkSelector = 'a', // Ищем ссылку внутри элемента
    this.dateSelector = '.news-block-content',
    this.imageSelector = '.uk-card-media-top img',
  });
}

class NewsService {
  // Базовый метод, который мы использовали раньше (для совместимости)
  Future<List<NewsItem>> fetchNews() async {
    return fetchSection(SectionConfig(url: 'https://mirea.ru/news/'));
  }

  // Универсальный метод для любого раздела
  Future<List<NewsItem>> fetchSection(SectionConfig config) async {
    // Убираем пробелы из URL на всякий случай
    final cleanUrl = config.url.trim();

    final response = await http.get(Uri.parse(cleanUrl));

    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final newsItems = document.querySelectorAll(config.itemSelector);

      List<NewsItem> newsList = newsItems.map((element) {
        // 1. Заголовок
        final titleElement = element.querySelector(config.titleSelector);
        final title = titleElement?.text.trim() ?? '';

        // 2. Ссылка (ищем тег <a> внутри элемента)
        final linkElement = element.querySelector(config.linkSelector);
        String linkHref = linkElement?.attributes['href'] ?? '';

        // Исправляем ссылку, если она относительная
        if (linkHref.isNotEmpty && !linkHref.startsWith('http')) {
          linkHref = 'https://mirea.ru$linkHref';
        }

        // 3. Дата
        final dateContainer = element.querySelector(config.dateSelector);
        String date = '';
        if (dateContainer != null) {
          // Пытаемся найти текст даты (логика из твоего кода)
          final dateNode = dateContainer.nodes.lastWhere(
            (node) => node.text?.trim().isNotEmpty ?? false,
          );
          date = dateNode.text?.trim() ?? '';
        }

        // 4. Изображение
        final imageElement = element.querySelector(config.imageSelector);
        String imageUrl = imageElement?.attributes['src'] ??
            imageElement?.attributes['data-src'] ??
            '';

        // Исправляем ссылку на картинку, если она относительная
        if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
          imageUrl = 'https://www.mirea.ru$imageUrl';
        }

        return NewsItem(
          title: title,
          date: date,
          imageUrl: imageUrl,
          link: linkHref,
          description: '',
        );
      }).toList();

      return newsList;
    } else {
      throw Exception('Не удалось загрузить раздел: ${response.statusCode}');
    }
  }

  // Метод для загрузки нескольких разделов одновременно
  Future<List<NewsItem>> fetchAllSections(List<SectionConfig> sections) async {
    final results =
        await Future.wait(sections.map((section) => fetchSection(section)));
    // Объединяем все списки в один
    return results.expand((item) => item).toList();
  }
}
