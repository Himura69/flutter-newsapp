// news_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {
  static const String apiKey = '199e0ab0be3d48b6a21c944315629039';

  Future<List<Article>> fetchNews({String query = ''}) async {
    final url = query.isEmpty
        ? 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'
        : 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Article> articles = (data['articles'] as List)
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<Article>> fetchTrendingNews() async {
    final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Article> trendingArticles = (data['articles'] as List)
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();
        return trendingArticles;
      } else {
        throw Exception('Failed to load trending news');
      }
    } catch (e) {
      throw Exception('Error fetching trending news: $e');
    }
  }
}
