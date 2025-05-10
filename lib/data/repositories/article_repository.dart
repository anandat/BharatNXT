import 'package:dio/dio.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final Dio _dio;

  ArticleRepository(this._dio);

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await _dio.get('/posts');
      return (response.data as List)
          .map((json) => Article.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load articles');
    }
  }
}
