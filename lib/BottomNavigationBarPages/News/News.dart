import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NewsDetailPage.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('http://10.169.28.210:5000/api/users/getAllNews'));
   
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      for (var item in data) {
        print(item['title']);
        
        String folderName = item['title']; // Using the title as the folder name

        String imageUrl = await getImageUrl(folderName);
        print("HEREEEEEEE $imageUrl");
        setState(() {
          newsItems.add({
            'title': item['title'],
            'date': item['date'],
            'image': imageUrl,
            'description' : item['description'],
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
                      description: news['description']!, // Ensure you fetch this from the server
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
                        width: double.infinity, // or a specific width like screenWidth * 0.9
                        height: screenHeight * 0.4, // or a specific height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            news['image']!,
                            fit: BoxFit.contain, // Change this to BoxFit.contain
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
