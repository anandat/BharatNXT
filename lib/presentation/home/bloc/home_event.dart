import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadArticles extends HomeEvent {}

class SearchArticles extends HomeEvent {
  final String query;

  SearchArticles(this.query);

  @override
  List<Object> get props => [query];
}
class ToggleFavorite extends HomeEvent {
  final int articleId;

  ToggleFavorite(this.articleId);

  @override
  List<Object> get props => [articleId];
}


