import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/news/news_item.dart';
import '../../bloc/news_bloc/news_bloc.dart';
import '../../bloc/news_bloc/news_event.dart';
import '../../bloc/news_bloc/news_state.dart';
import '../../../data/services/news_service.dart';
import '../widgets/custom_widget.dart';

class NewsListWidget extends StatelessWidget {
  NewsListWidget({super.key});

  final List<HorizontalNewsItem> horizontalNewsItems = [
    HorizontalNewsItem(
      title: 'Сети',
      link: 'https://elibrary.ru/download/elibrary_42967869_72268807.pdf',
      imageUrl:
          'https://i.pinimg.com/736x/48/63/24/4863249173669c2e98a78aaebba5445c.jpg',
    ),
    HorizontalNewsItem(
      title: 'Методы ИИ',
      link: 'https://elibrary.ru/download/elibrary_11928264_57310922.pdf',
      imageUrl:
          'https://i.pinimg.com/736x/8b/da/d7/8bdad7e0d011acb6e5fc446b6d640f7a.jpg',
    ),
    HorizontalNewsItem(
      title: 'Профессия',
      link: 'https://elibrary.ru/download/elibrary_62405836_64487740.pdf',
      imageUrl:
          'https://i.pinimg.com/736x/09/f4/90/09f4908b96a4ed1becc04a1e7316e5f4.jpg',
    ),
    HorizontalNewsItem(
      title: 'Полезное',
      link: 'https://elibrary.ru/download/elibrary_47370951_14590585.pdf',
      imageUrl:
          'https://i.pinimg.com/736x/13/73/37/137337f6268883bb5accfe8a991543d3.jpg',
    ),
  ];

  Future<void> _refreshData(BuildContext context) async {
    BlocProvider.of<NewsBloc>(context).add(RefreshNews());
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Новости',
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        backgroundColor: Colors.white,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return Column(
                children: [
                  SizedBox(
                    height: 200, // Высота горизонтального списка
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: horizontalNewsItems.length,
                      itemBuilder: (context, index) {
                        final newsItem = horizontalNewsItems[index];
                        return HorizontalNewsCard(newsItem: newsItem);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final newsItem =
                            state.news[index]; // Теперь это объект NewsItem
                        return NewsCard(
                            newsItem:
                                newsItem); // Используем новый виджет NewsCard
                      },
                    ),
                  ),
                ],
              );
            } else if (state is NewsError) {
              return Center(child: Text('Ошибка: ${state.message}'));
            }
            return const Center(child: Text('Новости недоступны'));
          },
        ),
      ),
    );
  }
}

class HorizontalNewsItem {
  final String title;
  final String imageUrl;
  final String link;

  HorizontalNewsItem({
    required this.title,
    required this.imageUrl,
    required this.link,
  });
}

class HorizontalNewsCard extends StatelessWidget {
  final HorizontalNewsItem newsItem;

  const HorizontalNewsCard({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = newsItem.link;
        _launchInBrowser(Uri.parse(url));
      },
      child: Container(
        width: 150, // Ширина карточки
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(newsItem.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54, // Полупрозрачный фон для текста
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              newsItem.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsItem newsItem;

  const NewsCard({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              newsItem.imageUrl, // URL изображения
              fit: BoxFit.cover,
              height: 150, // Высота изображения
              width: double.infinity, // Ширина изображения
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                    'Ошибка загрузки изображения'); // Обработка ошибок загрузки изображения
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsItem.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Опубликовано: ${newsItem.date}', // Дата публикации
                  style: const TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () async {
                    final url = newsItem.link; // Получаем ссылку на новость
                    _launchInBrowser(Uri.parse(url));
                  },
                  child: const Text('Читать',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
