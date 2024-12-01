import 'package:flutter/material.dart';
import 'detail_page.dart'; // Pastikan Anda memiliki file detail_page.dart
import 'news_model.dart';  // Pastikan model 'Article' digunakan di sini

class TrendingPage extends StatelessWidget {
  final List<Article> trendingArticles;

  TrendingPage({required this.trendingArticles});

  void _navigateToDetailPage(BuildContext context, Article article) {
    // Navigasi ke halaman DetailPage dengan artikel yang dipilih
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mendeteksi apakah mode gelap atau terang
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Menggunakan warna yang sama dengan HomePage untuk background
    Color backgroundColor = isDarkMode ? Color(0xFF121212) : Color(0xFFB0BEC5); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF212121) : Color(0xFFB0BEC5), // AppBar sesuai mode
        title: Text('Trending News', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: backgroundColor, // Menggunakan background color yang sama dengan HomePage
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          itemCount: trendingArticles.length,
          itemBuilder: (context, index) {
            final article = trendingArticles[index];
            return Card(
              margin: EdgeInsets.only(bottom: 16), // Jarak antar Card
              color: isDarkMode ? Color(0xFF37474F) : Color(0xFFFAFAFA), // Card color sesuai mode
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5, // Efek bayangan untuk Card
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Memastikan gambar berbentuk bulat
                  child: article.urlToImage.isNotEmpty
                      ? Image.network(
                          article.urlToImage,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image, size: 60, color: isDarkMode ? Colors.grey[300] : Colors.grey),
                ),
                title: Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    article.description,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                onTap: () {
                  _navigateToDetailPage(context, article); // Navigasi ke halaman detail saat artikel ditekan
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
