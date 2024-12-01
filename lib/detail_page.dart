import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Required for storing comments locally
import 'news_model.dart'; // Import the Article model

class DetailPage extends StatefulWidget {
  final Article article; // Change the type to Article model

  // Constructor to accept the selected article
  DetailPage({required this.article});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController _commentController = TextEditingController();
  List<String> _comments = []; // List to hold comments

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  // Load existing comments from SharedPreferences or any other storage
  void _loadComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _comments = prefs.getStringList(widget.article.title) ?? [];
    });
  }

  // Add new comment to the list and save to SharedPreferences
  void _addComment() async {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(_commentController.text);
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(widget.article.title, _comments);

      _commentController.clear(); // Clear the input field
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF212121) : Color(0xFFB0BEC5),
        title: Text(
          'Detail News',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display image if available
              widget.article.urlToImage.isNotEmpty
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      child: Image.network(
                        widget.article.urlToImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    )
                  : Container(
                      height: 250,
                      color: Colors.grey[300],
                      child:
                          Icon(Icons.image, size: 100, color: Colors.grey[600]),
                    ),
              SizedBox(height: 16),

              // Article Title
              Text(
                widget.article.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),

              // Article Description
              Text(
                widget.article.description,
                style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                    fontSize: 14),
              ),
              SizedBox(height: 20),

              // Comments Section Header
              Text(
                'Comments',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 10),

              // ListView of Comments
              _comments.isEmpty
                  ? Text(
                      'No comments yet. Be the first to comment!',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        fontSize: 16,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              _comments[index],
                              style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            tileColor: isDarkMode
                                ? Color(0xFF424242)
                                : Colors.grey[200],
                          ),
                        );
                      },
                    ),

              SizedBox(height: 20),

              // Input Field for New Comment
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        filled: true,
                        fillColor:
                            isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: isDarkMode ? Colors.white : Colors.black87,
                    onPressed: _addComment,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
