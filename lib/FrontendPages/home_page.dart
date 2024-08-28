// home_page.dart

import 'package:flutter/material.dart';
import 'event_page.dart';
import 'profile_page.dart';
import 'Filter_Page.dart';

import 'bottom_navigation.dart';
import 'up_logo.dart'; // Import the custom app bar
import 'ShopPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      ListView.builder(
        itemCount: newsItems.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Top stories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 94, 132),
                ),
              ),
            );
          }
          final news = newsItems[index - 1];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventPage()),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(news['image']!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          news['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 94, 132),
                          ),
                        ),
                        Text(
                          news['date']!,
                          style: TextStyle(
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
      ShopPage(),
      FilterPage(),
      ProfilePage(), // Add the ProfilePage here
    ];

    return Scaffold(
      appBar: CustomAppBar(), // Use the custom app bar
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
