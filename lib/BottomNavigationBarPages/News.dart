import 'package:flutter/material.dart';

class News extends StatelessWidget {
  News({super.key});

  final List<Map<String, String>> newsItems = [
    {
      'title': 'News Title 1',
      'date': '2024-07-01',
      'image': 'assets/images/news.jpeg',
    },
    {
      'title': 'News Title 2',
      'date': '2024-06-30',
      'image': 'assets/images/event.jpeg',
    },
    {
      'title': 'News Title 3',
      'date': '2024-06-29',
      'image': 'assets/images/event.jpeg',
    },
  ];

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
                      fontSize: screenWidth * 0.04, // Font size relative to screen width
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
                      Image.asset(
                        news['image']!,
                        width: screenWidth,
                        height: screenHeight * 0.25, // Image height relative to screen height
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
                                fontSize: screenWidth * 0.035, // Font size relative to screen width
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 94, 132),
                              ),
                            ),
                            Text(
                              news['date']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.025, // Font size relative to screen width
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
