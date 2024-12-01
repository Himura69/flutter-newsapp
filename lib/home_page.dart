// home_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'category_page.dart';
import 'detail_page.dart';
import 'trending_page.dart';
import 'news_service.dart';
import 'news_model.dart';
import 'profile_page.dart'; // Import ProfilePage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> articles = [];
  List<Article> trendingArticles = [];
  bool isLoading = true;
  String searchQuery = '';
  bool isDarkMode = false;
  final TextEditingController _searchController = TextEditingController();

  final NewsService _newsService = NewsService();

  Future<void> fetchNews({String query = ''}) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedArticles = await _newsService.fetchNews(query: query);
      setState(() {
        articles = fetchedArticles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching news: $e');
    }
  }

  Future<void> fetchTrendingNews() async {
    try {
      final fetchedTrendingArticles = await _newsService.fetchTrendingNews();
      setState(() {
        trendingArticles = fetchedTrendingArticles;
      });
    } catch (e) {
      print('Error fetching trending news: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
    fetchTrendingNews();
  }

  void _navigateToDetailPage(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(article: article),
      ),
    );
  }

  void _navigateToTrendingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrendingPage(trendingArticles: trendingArticles),
      ),
    );
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(), // Navigate to ProfilePage
      ),
    );
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF121212) : Color(0xFFB0BEC5),
        title: Text(
          'INews',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.account_circle,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            _navigateToProfilePage(context); // Navigate to Profile Page
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_up,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              _navigateToTrendingPage(context);
            },
          ),
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              _toggleDarkMode();
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.grey,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: _searchController,
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Search News',
                  labelStyle: TextStyle(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.black),
                  prefixIcon: Icon(Icons.search,
                      color: isDarkMode ? Colors.white : Colors.black),
                  filled: true,
                  fillColor: isDarkMode ? Color(0xFF121212) : Color(0xFFE0E0E0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                  fetchNews(query: query);
                },
              ),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: isDarkMode ? Colors.black : Color(0xFFEEEEEE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: article.urlToImage.isNotEmpty
                                ? Image.network(
                                    article.urlToImage,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.image,
                                    size: 50,
                                    color: isDarkMode
                                        ? Colors.grey[300]
                                        : Colors.grey),
                            title: Text(
                              article.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              article.description,
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () =>
                                _navigateToDetailPage(context, article),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? Color(0xFF121212) : Color(0xFFB0BEC5),
        selectedItemColor: isDarkMode ? Colors.white : Colors.black,
        unselectedItemColor: isDarkMode ? Colors.grey : Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()),
            );
          } else if (index == 2) {
            _navigateToTrendingPage(context); // Navigate to Trending Page
          }
        },
      ),
    );
  }
}
