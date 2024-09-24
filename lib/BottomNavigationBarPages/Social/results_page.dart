import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'PublicProfilePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ResultsPage extends StatefulWidget {
  final String combinedFilters ;
  ResultsPage({required this.combinedFilters});
  @override
  _ResultsPageState createState() => _ResultsPageState();
}
class _ResultsPageState extends State<ResultsPage> {
  TextEditingController _searchController = TextEditingController();
  late List<Map<String, String>> filteredProfiles;
   final _storage = FlutterSecureStorage();
   final storage = FirebaseStorage.instance;
  List<dynamic> _users = [];
  bool _isLoading = true;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
  final email = await _storage.read(key: 'email');
  if (email == null) {
    setState(() {
      _isLoading = false;
      _errorMessage = 'User email is not available';
    });
    return;
  }

  String filter =widget.combinedFilters;
  print("FILEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEer");
  print(filter);
  final response = await http.get(
    Uri.parse('https://gentle-retreat-85040-e271e09ef439.herokuapp.com/api/users/usersByFilter?email=$email&$filter'),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    try {
      final data = jsonDecode(response.body);
      if (data is List) {
        final List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(data);
        final List<Map<String, dynamic>> usersWithImages = [];

        for (final user in users) {
          final email = user['email'];
          if (email != null) {
            final imageUrl = await getImageUrl(email);
            usersWithImages.add({
              'imageUrl': imageUrl,
              'name': user['username'] ?? 'Unknown Name',
              'email': user['email'] ?? 'Unknown email',
              'showMessageButton': true, // Set this based on your requirements
            });
          }
        }

        setState(() {
          _users = usersWithImages;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Unexpected data format';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error parsing JSON: $e';
      });
    }
  } else {
    setState(() {
      _isLoading = false;
      _errorMessage = 'Failed to load users';
    });
  }
}
 @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,  // Remove the back arrow
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            'Users List',
            style: TextStyle(fontSize: screenHeight * 0.025, color: Colors.black), // 2.5% of screen height
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child : Column(
          children: [
            Expanded(
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 6,
      mainAxisSpacing: 10,
      childAspectRatio: 0.90,
    ),
    itemCount: _users.length,
    itemBuilder: (context, index) {
      final user = _users[index];
      return _buildProfileCard(
        user['imageUrl'] ?? '',  // Ensure imageUrl is provided
        user['name'] ?? 'Unknown Name',
        user['email'] ?? 'Unknown email',
        showMessageButton: user['showMessageButton'] ?? false,
      );
    },
  ),
),

          ],
        ),
        
        ),
        
    );
  }

  Widget _buildProfileCard(String imageUrl, String name, String email, {bool showMessageButton = false}) {
  return InkWell(
    onTap: () {
      // Navigate to another page when the card is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PublicProfilePage()),
      );
    },
    child: Card(
      child: Column(
        children: [
          imageUrl.isNotEmpty
              ? Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover)
              : Icon(Icons.account_circle, size: 100), // Fallback icon if imageUrl is empty
          Text(name),
          Text(email),
          if (showMessageButton)
            ElevatedButton(
              onPressed: () {
                // Handle message button press
              },
              child: Text('Message'),
            ),
        ],
      ),
    ),
  );
}





Future<String> getImageUrl(String userEmail) async {
    try {
      final ref = storage.ref().child('profiles/$userEmail');
      final ListResult result = await ref.listAll();
      final String url = await result.items.first.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching profile image for $userEmail: $e');
      return ''; // Return an empty string if an error occurs
    }
  }
}