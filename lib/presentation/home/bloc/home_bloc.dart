import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../../../data/models/article_model.dart';
import '../../../../data/repositories/article_repository.dart';
import '../../../../core/storage/favorites_storage.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ArticleRepository repository;
  final FavoritesStorage storage;

  List<Article> _allArticles = [];

  HomeBloc({
    required this.repository,
    required this.storage,
  }) : super(HomeLoading()) {
    on<LoadArticles>(_onLoadArticles);
    on<SearchArticles>(_onSearchArticles);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadArticles(
      LoadArticles event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final List<Article> articles = await repository.fetchArticles();


      final List<int> favoriteIds = await storage.loadFavoriteIds();


      _allArticles = articles.map((article) {
        return article.copyWith(
          isFavorite: favoriteIds.contains(article.id),
        );
      }).toList();

      emit(HomeLoaded(_allArticles));
    } catch (e) {
      emit(HomeError('Failed to fetch articles.'));
    }
  }

  void _onSearchArticles(
      SearchArticles event, Emitter<HomeState> emit) {
    final query = event.query.toLowerCase();
    final List<Article> filtered = _allArticles.where((article) {
      return article.title.toLowerCase().contains(query) ||
          article.body.toLowerCase().contains(query);
    }).toList();

    emit(HomeLoaded(filtered));
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<HomeState> emit) async {
    _allArticles = _allArticles.map((article) {
      if (article.id == event.articleId) {
        return article.copyWith(isFavorite: !article.isFavorite);
      }
      return article;
    }).toList();

    final favoriteIds = _allArticles
        .where((a) => a.isFavorite)
        .map((a) => a.id)
        .toList();
    await storage.saveFavoriteIds(favoriteIds);

    emit(HomeLoaded(_allArticles));
  }
}
