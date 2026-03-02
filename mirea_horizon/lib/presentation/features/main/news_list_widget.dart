import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/news/news_item.dart';
import '../../bloc/news_bloc/news_bloc.dart';
import '../../bloc/news_bloc/news_event.dart';
import '../../bloc/news_bloc/news_state.dart';
import '../widgets/custom_widget.dart';

class NewsListWidget extends StatefulWidget {
  const NewsListWidget({super.key});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Конфигурация вкладок
  final List<TabConfig> _tabs = [
    TabConfig(title: 'Новости', url: 'https://mirea.ru/news/'),
    TabConfig(
        title: 'Карьера',
        url:
            'https://www.mirea.ru/news/index.php?set_filter=Y&arrFilter_ff%5BTAGS%5D=%D0%BA%D0%B0%D1%80%D1%8C%D0%B5%D1%80%D0%B0'),
    TabConfig(
        title: 'Достижения университета',
        url:
            'https://www.mirea.ru/news/index.php?set_filter=Y&arrFilter_ff%5BTAGS%5D=%D0%B4%D0%BE%D1%81%D1%82%D0%B8%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F+%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%82%D0%B5%D1%82%D0%B0'),
    TabConfig(
        title: "Инфраструктура",
        url:
            'https://www.mirea.ru/news/index.php?set_filter=Y&arrFilter_ff%5BTAGS%5D=%D0%B8%D0%BD%D1%84%D1%80%D0%B0%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0')
  ];

  // Горизонтальные карточки (статичные)
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    // Загружаем данные для первой вкладки
    _loadNewsForCurrentTab();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;
    _loadNewsForCurrentTab();
  }

  void _loadNewsForCurrentTab() {
    final url = _tabs[_tabController.index].url;
    BlocProvider.of<NewsBloc>(context).add(LoadNewsByUrl(url));
  }

  Future<void> _refreshData() async {
    _loadNewsForCurrentTab();
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Новости',
      bottom: TabBar(
        tabAlignment: TabAlignment.start,
        controller: _tabController,
        tabs: _tabs.map((tab) => Tab(text: tab.title)).toList(),
        labelColor: Theme.of(context).colorScheme.onSurface,
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            // Горизонтальный список (статичный)
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: horizontalNewsItems.length,
                itemBuilder: (context, index) {
                  return HorizontalNewsCard(
                      newsItem: horizontalNewsItems[index]);
                },
              ),
            ),
            // Контент вкладок
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NewsLoaded) {
                    return state.news.isEmpty
                        ? const Center(child: Text('Нет новостей'))
                        : ListView.builder(
                            itemCount: state.news.length,
                            itemBuilder: (context, index) {
                              return NewsCard(newsItem: state.news[index]);
                            },
                          );
                  } else if (state is NewsError) {
                    return Center(child: Text('Ошибка: ${state.message}'));
                  }
                  return const Center(child: Text('Новости недоступны'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Модель вкладки
class TabConfig {
  final String title;
  final String url;
  TabConfig({required this.title, required this.url});
}

// Модель горизонтальной карточки
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

// Виджет горизонтальной карточки
class HorizontalNewsCard extends StatelessWidget {
  final HorizontalNewsItem newsItem;
  const HorizontalNewsCard({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchInBrowser(Uri.parse(newsItem.link)),
      child: Container(
        width: 150,
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
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              newsItem.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
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

// Виджет карточки новости
class NewsCard extends StatelessWidget {
  final NewsItem newsItem;
  const NewsCard({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              newsItem.imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  const Text('Ошибка загрузки изображения'),
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
                  'Опубликовано: ${newsItem.date}',
                  style: const TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () => _launchInBrowser(Uri.parse(newsItem.link)),
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
  print("URL $url");
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
