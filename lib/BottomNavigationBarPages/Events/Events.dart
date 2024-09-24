import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
class Events extends StatefulWidget {
  const Events({super.key});
  @override
  _EventsState createState() => _EventsState();
}
class _EventsState extends State<Events> {
  final storage = FirebaseStorage.instance;
  List<Map<String, dynamic>> newsItems = [];
  @override
  void initState() {
    super.initState();
    fetchNews();
  }
  Future<String> getImageUrl(String folderName) async {
     try {
      print("hereer");
      final front = storage.ref().child('events/$folderName/front'); 
      final ListResult result = await front.listAll();
      final ref = result.items.first;
      final url = await ref.getDownloadURL();
     
      return url;
    } catch (e) {
      
      return '';
      }
  }
  // Future<List<String>> getPicturesUrls(String folderName) async {
  //   try {
  //     final picturesRef = storage.ref().child('$folderName/pictures');
  //     final ListResult result = await picturesRef.listAll();
  //     List<String> urls = [];
  //     for (var ref in result.items) {
  //       String url = await ref.getDownloadURL();
  //       urls.add(url);
  //     }
      
  //     return urls;
  //   } catch (e) {
      
  //     return [];
  //   }
  // }
  Future<void> fetchNews() async {
    

    final response = await http.get(Uri.parse('https://gentle-retreat-85040-e271e09ef439.herokuapp.com/api/users/getAllEvents'));
   
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      
      for (var item in data) {
        
        
        String folderName = item['title']; // Using the title as the folder name

        String imageUrl = await getImageUrl(folderName);
             
        setState(() {
          newsItems.add({
            'title': item['title'],
            'date': item['date'],
            'time': item['time'],
            'location' : item['location'],
            'image': imageUrl,
            'description' : item['description'],
            
          });
        });
        
      }
    } else {
       print('Error: ${response.body}');
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => NewsDetailPage(
                //       title: news['title']!,
                //       imageUrl: news['image']!,
                //       description: news['description']!,
                //       picturesUrl: news['pictures'],
                //     ),
                //   ),
                // );
              },
              child: Card(

                margin: EdgeInsets.all(screenWidth * 0.04),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Container
                      Container(
                        width: screenWidth * 0.30, // Smaller width for the image
                        height: screenHeight * 0.15, // Adjust height to maintain aspect ratio
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            news['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text('Image not found'));
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04), // Spacing between image and text
                      // Title and Date Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news['title']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 94, 132),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              news['date']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              news['time']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              news['location'],
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
