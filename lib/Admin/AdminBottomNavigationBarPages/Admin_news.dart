import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AdminNews extends StatefulWidget {
  const AdminNews({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminNews createState() => _AdminNews();
}

class _AdminNews extends State<AdminNews> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _singleImageFile;
  final List<File> _multipleImageFiles = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickSingleImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _singleImageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickMultipleImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _multipleImageFiles.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }
  Future<String?> _uploadImage(File imageFile, String title, String folderName) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('news/$title/$folderName/${imageFile.uri.pathSegments.last}');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
  Future<void> _submitNews() async {
    final String title = _titleController.text;
    final String date = _dateController.text;
    final String description = _descriptionController.text;

    if (title.isEmpty || date.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }
    String? singleImageUrl;
    if (_singleImageFile != null) {
      singleImageUrl = await _uploadImage(_singleImageFile!, title, 'front');
    }
    List<String> multipleImageUrls = [];
    for (var imageFile in _multipleImageFiles) {
      final imageUrl = await _uploadImage(imageFile, title, 'pictures');
      if (imageUrl != null) {
        multipleImageUrls.add(imageUrl);
      }
    }
    final newsData = {
      'title': title,
      'date': date,
      'description': description,
      'imageUrl': singleImageUrl,
      'additionalImages': multipleImageUrls,
    };

    final response = await http.post(
      Uri.parse('https://gentle-retreat-85040-e271e09ef439.herokuapp.com/api/users/postNews'),
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
            _singleImageFile == null
                ? Text('No single image selected.')
                : Text("Single image added"),
            ElevatedButton(
              onPressed: _pickSingleImage,
              child: Text('Pick Single Image'),
            ),
            SizedBox(height: 16.0),
            _multipleImageFiles.isEmpty
                ? Text('No multiple images selected.')
                : Text("${_multipleImageFiles.length} images added"),
            ElevatedButton(
              onPressed: _pickMultipleImages,
              child: Text('Pick Multiple Images'),
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
