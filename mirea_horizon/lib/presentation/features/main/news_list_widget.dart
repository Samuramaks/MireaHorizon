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
  const NewsListWidget({super.key});

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
              return ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final newsItem =
                      state.news[index]; // Теперь это объект NewsItem
                  return NewsCard(
                      newsItem: newsItem); // Используем новый виджет NewsCard
                },
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
