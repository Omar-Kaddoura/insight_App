import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News extends StatefulWidget {
  const News({super.key});

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<Map<String, dynamic>> newsItems = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('http://192.168.0.124:5000/api/users/getAllNews'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        newsItems = data.map((item) => {
          'title': item['title'],
          'date': item['date'],
          'image': 'assets/images/news.jpeg',
        }).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        return Scaffold(
          body: ListView.builder(
            itemCount: newsItems.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.001,
                  ),
                  child: Text(
                    'Top stories',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 94, 132),
                    ),
                  ),
                );
              }
              final news = newsItems[index - 1];
              return GestureDetector(
                onTap: () {
                  // Handle tap
                },
                child: Card(
                  margin: EdgeInsets.all(screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        news['image']!,
                        width: screenWidth,
                        height: screenHeight * 0.25,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              news['title']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 94, 132),
                              ),
                            ),
                            Text(
                              news['date']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
