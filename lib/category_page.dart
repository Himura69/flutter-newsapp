import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_page.dart'; // Importing the DetailPage
import 'news_model.dart'; // Import the Article model

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Article> articles = []; // Change from List<dynamic> to List<Article>
  bool isLoading = true;
  String selectedCategory = 'business'; // Default category
  bool isDarkMode = false;

  final List<String> categories = [
    'business',
    'sports',
    'technology',
    'entertainment',
    'health'
  ];

  Future<void> fetchCategoryNews(String category) async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=199e0ab0be3d48b6a21c944315629039';
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // Convert each article map to an Article object
          articles = (data['articles'] as List)
              .map((articleJson) => Article.fromJson(articleJson))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load category news');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching category news: $e');
    }
  }

  void _navigateToDetailPage(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPage(article: article), // Passing the Article object here
      ),
    );
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryNews(selectedCategory); // Fetch news for the default category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode
            ? Color(0xFF121212) // Dark mode color (same as HomePage)
            : Color(0xFFB0BEC5), // Light mode color (same as HomePage)
        title: Text(
          'Categories',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              _toggleDarkMode(); // Toggle dark mode
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.grey,
          ),
        ],
      ),
      body: Container(
        color:
            Colors.grey[300], // Set a light grey background for the whole page
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select category
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Color(0xFF37474F)
                      : Color(
                          0xFFE0E0E0), // Lighter gray background for the dropdown
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: isDarkMode ? Color(0xFF6A1B9A) : Colors.grey),
                ),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newCategory) {
                    if (newCategory != null) {
                      setState(() {
                        selectedCategory = newCategory;
                        isLoading =
                            true; // Set loading to true when changing category
                      });
                      fetchCategoryNews(
                          selectedCategory); // Fetch news for the selected category
                    }
                  },
                  underline: SizedBox(),
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  dropdownColor: isDarkMode ? Color(0xFF2E1A47) : Colors.white,
                  isExpanded: true,
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category[0].toUpperCase() + category.substring(1),
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // If loading, show progress indicator
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: isDarkMode
                              ? Color(0xFF2A2A2A)
                              : Color(
                                  0xFFF5F5F5), // Light grey background for cards
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
    );
  }
}
