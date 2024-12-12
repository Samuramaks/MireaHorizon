// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../data/services/news_service.dart';
// import 'news_event.dart';
// import 'news_state.dart';

// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsService _newsService;

//   NewsBloc({required NewsService newsService})
//       : _newsService = newsService,
//         super(NewsInitial()) {
//     on<FetchNews>(_onFetchNews);
//     on<RefreshNews>(_onRefreshNews);
//   }

//   Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
//     try {
//       emit(NewsLoading());
//       final news = await _newsService.fetchNews();
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }

//   Future<void> _onRefreshNews(
//       RefreshNews event, Emitter<NewsState> emit) async {
//     try {
//       final news = await _newsService.fetchNews();
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../data/services/news_service.dart';
// import 'news_event.dart'; // Импортируйте события
// import 'news_state.dart'; // Импортируйте состояния

// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsService _newsService;

//   NewsBloc(this._newsService) : super(NewsInitial()) {
//     on<FetchNews>(_onFetchNews);
//     on<RefreshNews>(_onRefreshNews);
//   }

//   Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
//     try {
//       emit(NewsLoading());
//       final news = await _newsService.fetchNews(); // Используйте fetchNews
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }

//   Future<void> _onRefreshNews(
//       RefreshNews event, Emitter<NewsState> emit) async {
//     try {
//       final news = await _newsService.fetchNews(); // Используйте fetchNews
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../data/services/news_service.dart';
// import 'news_event.dart';
// import 'news_state.dart';

// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsService _newsService;

//   NewsBloc(this._newsService) : super(NewsInitial()) {
//     on<FetchNews>(_onFetchNews);
//     on<RefreshNews>(_onRefreshNews);
//   }

//   Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
//     try {
//       emit(NewsLoading());
//       final news = await _newsService.fetchNews(); // Теперь это List<NewsItem>
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }

//   Future<void> _onRefreshNews(
//       RefreshNews event, Emitter<NewsState> emit) async {
//     try {
//       final news = await _newsService.fetchNews(); // Теперь это List<NewsItem>
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/news_service.dart';
import 'news_event.dart'; // Импортируйте события
import 'news_state.dart'; // Импортируйте состояния

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService;

  // Измените конструктор, чтобы принимать newsService
  NewsBloc({required NewsService newsService})
      : _newsService = newsService,
        super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
    on<RefreshNews>(_onRefreshNews);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final news = await _newsService.fetchNews(); // Теперь это List<NewsItem>
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onRefreshNews(
      RefreshNews event, Emitter<NewsState> emit) async {
    try {
      final news = await _newsService.fetchNews(); // Теперь это List<NewsItem>
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
