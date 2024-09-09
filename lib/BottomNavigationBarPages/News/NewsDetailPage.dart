import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {

  
  final String title;
  final String imageUrl;
  final String description;
  final List<String> picturesUrl;

  const NewsDetailPage({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.picturesUrl,
  }) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {

late List<Widget> _pages;


@override
void initState(){
  super.initState();
  _pages = List.generate(widget.picturesUrl.length,
   (index) => Image.network(
    widget.picturesUrl[index],
    fit:BoxFit.cover,
    errorBuilder: (context,error,stackTrace){
      return const Center(child: Text('Image not Found'),);
    },
    ));

  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 0, 94, 132),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not found'));
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20,),
            Stack(
              children: [
                SizedBox(
                  
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4,
                  child: PageView.builder(
                    itemCount: widget.picturesUrl.length,
                    itemBuilder: (context, index) {
                      return _pages[index]; // Replace with your widget content
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
