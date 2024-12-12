import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/news_item.dart';
import '../../bloc/news_bloc/news_bloc.dart';
import '../../bloc/news_bloc/news_event.dart';
import '../../bloc/news_bloc/news_state.dart';
import '../../../data/services/news_service.dart';
import '../widgets/custom_widget.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Новости',
      body: BlocProvider(
        create: (context) => NewsBloc(
          newsService: NewsService(), // Инициализация NewsService
        )..add(FetchNews()), // Добавление события для загрузки новостей
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

  const NewsCard({Key? key, required this.newsItem}) : super(key: key);

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
            child: Text(
              newsItem.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              newsItem.description, // Описание новости
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Опубликовано: ${newsItem.date}', // Дата публикации
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
