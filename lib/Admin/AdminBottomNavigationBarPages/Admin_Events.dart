import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
class AdminEvents extends StatefulWidget{
  const AdminEvents ({super.key});
  
  @override
  _AdminEvents createState() => _AdminEvents();
}

class _AdminEvents extends State<AdminEvents> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  

  File? _singleImageFile;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickSingleImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _singleImageFile = File(pickedFile.path);
      });
    }
  }

   Future<String?> _uploadImage(File imageFile, String title, String folderName) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('events/$title/$folderName/${imageFile.uri.pathSegments.last}');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _submitEvents() async {
    final String title = _titleController.text;
    final String date = _dateController.text;
    final String time = _timeController.text;
    final String location = _locationController.text;
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

    print('OMAAAAAAAAAAAAAAAR');

    final eventsData = {
  'title': title,
  'date': date,
  'time': time,
  'location': location, 
  'description': description,
};

    
    print(eventsData);

    final response = await http.post(
      Uri.parse('http://10.169.31.71:5000/api/users/postEvents'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(eventsData),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event to add news')),
      );
    }
  }




 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Add Events'),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
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
            ElevatedButton(
              onPressed: _submitEvents,
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    ),
  );
}

}