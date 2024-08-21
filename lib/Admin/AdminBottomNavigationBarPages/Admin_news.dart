import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminNews extends StatefulWidget {
  @override
  _AdminNews createState() => _AdminNews();
}

class _AdminNews extends State<AdminNews> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submitNews() async {
    final String title = _titleController.text;
    final String date = _dateController.text;
    final String description = _descriptionController.text;

    if (title.isEmpty || date.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    final newsData = {
      'title': title,
      'date': date,
      'description': description,
    };

    final response = await http.post(
      Uri.parse('http://192.168.0.124:5000/api/users/postNews'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(newsData),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('News added successfully!')),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add news')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitNews,
              child: Text('Add News'),
            ),
          ],
        ),
      ),
    );
  }
}
