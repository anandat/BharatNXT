import 'package:equatable/equatable.dart';
import '../../../../data/models/article_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Article> articles;

  HomeLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
