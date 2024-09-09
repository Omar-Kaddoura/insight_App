import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NewsDetailPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
class News extends StatefulWidget {
  const News({super.key});
  @override
  _NewsState createState() => _NewsState();
}
class _NewsState extends State<News> {
  final storage = FirebaseStorage.instance;
  List<Map<String, dynamic>> newsItems = [];
  @override
  void initState() {
    super.initState();
    fetchNews();
  }
  Future<String> getImageUrl(String folderName) async {
     try {
      final front = storage.ref().child('$folderName/front'); 
      final ListResult result = await front.listAll();
      final ref = result.items.first;
      final url = await ref.getDownloadURL();
      print("front URL $url ");
      return url;
    } catch (e) {
      print('Error listing items in $folderName: $e');
      return '';
      }
  }
  Future<List<String>> getPicturesUrls(String folderName) async {
    try {
      final picturesRef = storage.ref().child('$folderName/pictures');
      final ListResult result = await picturesRef.listAll();
      List<String> urls = [];
      for (var ref in result.items) {
        String url = await ref.getDownloadURL();
        urls.add(url);
      }
      print("Pictures URLs for $folderName: $urls");
      return urls;
    } catch (e) {
      print('Error listing pictures in $folderName: $e');
      return [];
    }
  }
  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('http://10.169.29.139:5000/api/users/getAllNews'));
   
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      for (var item in data) {
        
        
        String folderName = item['title']; // Using the title as the folder name

        String imageUrl = await getImageUrl(folderName);
        List<String>  picturesUrl = await getPicturesUrls(folderName);        
        setState(() {
          newsItems.add({
            'title': item['title'],
            'date': item['date'],
            'image': imageUrl,
            'description' : item['description'],
            'pictures' : picturesUrl,
          });
        });
      }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(
                      title: news['title']!,
                      imageUrl: news['image']!,
                      description: news['description']!,
                      picturesUrl: news['pictures'],
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey, width: 2.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          news['image']!,
                          fit: BoxFit.cover, // Changed from BoxFit.contain to BoxFit.cover
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Text('Image not found'));
                          },
                        ),
                      ),
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
