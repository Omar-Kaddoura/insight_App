import 'dart:convert';
import 'package:flutter/material.dart';
import 'PublicProfilePage.dart';
import 'results_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insight/messaging/chat_screen.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final storage = FirebaseStorage.instance;
  final _storage = const FlutterSecureStorage();
  String? selectedFaculty;
  String? selectedMajor;
  String? companySearchQuery;
  bool showCompanySearchField = false;
  Set<String> selectedFilters = {};
  Set<String> pressedFilters = {};
  List<String> majors = [
    'Agri-Business',
    'Agri-culture',
    'Applied Mathematics',
    'Arabic',
    'Archaeology',
    'Architecture',
    'Art History',
    'Biology',
    'Business Administration',
    'Chemical Engineering',
    'Chemistry',
    'Civil and Environmental Engineering',
    'Computer and Communications Engineering',
    'Computer Science',
    'Construction Engineering',
    'Earth Sciences',
    'Electrical and Computer Engineering',
    'Elementary Education',
    'English Language',
    'English Literature',
    'Environmental Health',
    'Food Sciences and Management',
    'Graphic Design',
    'Health Communication',
    'History',
    'Industrial Engineering',
    'Landscape Architecture (BLA)',
    'Mathematics',
    'Mechanical Engineering',
    'Media and Communication',
    'Medical Imaging Sciences',
    'Medical Laboratory Sciences',
    'Nursing',
    'Nutrition and Dietetics',
    'Philosophy',
    'Physics',
    'Political Studies',
    'Psychology',
    'Public Administration',
    'Sociology-Anthropology',
    'Statistics',
    'Studio Arts'
  ];

  List<dynamic> _profiles = [];
  bool _isLoading = true;
  String? sEmail = '';
  String _errorMessage = '';
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _currentEmail();
    _fetchUsers();
  }

  Future<void> _currentEmail() async {
    String? E = await _storage.read(key: 'email');
    setState(() {
      sEmail = E;
    });
  }

  Future<String> getImageUrl(String userEmail) async {
    try {
      final ref = storage.ref().child('profiles/$userEmail');
      final ListResult result = await ref.listAll();
      final String url = await result.items.first.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching profile image for $userEmail: $e');
      return '';
    }
  }

  Future<void> _fetchUsers() async {
    // Get the stored email
    // const email = 'oyk01@mail.aub.edu';

    final email = await _storage.read(key: 'email');

    // Check if the email is null
    if (email == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'User email is not available';
        });
      }
      return;
    }

    try {
      // Make the GET request
      final response = await http.get(
        Uri.parse(
          'https://gentle-retreat-85040-e271e09ef439.herokuapp.com/api/users/usersByFilter?email=$email&cabinet=yes',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if the widget is still mounted after the HTTP request
      if (!mounted) return;
      print(sEmail);
      print(email);
      // Log the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check if the request was successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List) {
          if (mounted) {
            setState(() {
              _profiles = data;
              _isLoading = false;
            });
          }
        } else if (data is Map && data['users'] is List) {
          if (mounted) {
            setState(() {
              _profiles = data['users'];
              _isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Unexpected data format. Expected a List.';
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage =
                'Failed to load users: Status code ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      // Handle any other errors during the HTTP request
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error fetching users: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _profiles.isEmpty
                      ? Center(child: Text('No users found.'))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _profiles.length,
                          itemBuilder: (context, index) {
                            final user = _profiles[index];
                            return FutureBuilder<String>(
                              future: getImageUrl(user['email']),
                              builder: (context, snapshot) {
                                return _buildUserCard(user, snapshot);
                              },
                            );
                          },
                        ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (text) {},
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: null,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                          value: "Search by Faculty",
                          child: Text("Search by Faculty")),
                      DropdownMenuItem(
                          value: "Search by Major",
                          child: Text("Search by Major")),
                      DropdownMenuItem(
                          value: "Search by Alumni",
                          child: Text("Search by Alumni")),
                      DropdownMenuItem(
                          value: "Search by Undergrad",
                          child: Text("Search by Undergrad")),
                      DropdownMenuItem(
                          value: "Search by Grad",
                          child: Text("Search by Grad")),
                      DropdownMenuItem(
                          value: "Search by PHD", child: Text("Search by PHD")),
                      DropdownMenuItem(
                          value: "Search by Company",
                          child: Text("Search by Company")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          if (value.contains("Faculty")) {
                            _showFacultyOptions();
                          } else if (value.contains("Major")) {
                            _showMajorOptions();
                          } else if (value.contains("Alumni")) {
                            selectedFilters.add("Alumni");
                            pressedFilters.add('type=Alumni');
                          } else if (value.contains("Company")) {
                            showCompanySearchField = true;
                          } else if (value.contains("Undergrad")) {
                            selectedFilters.add("Undergrad");
                            pressedFilters.add('studies=Undergraduate');
                          } else if (value.contains("Grad")) {
                            selectedFilters.add("Grad");
                            pressedFilters.add('studies=Graduate');
                          } else if (value.contains("PHD")) {
                            selectedFilters.add("PHD");
                            pressedFilters.add('studies=PHD');
                          }
                        }
                      });
                    },
                    underline: Container(),
                  ),
                  SizedBox(height: 20),
                  if (showCompanySearchField)
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter company name',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          companySearchQuery = text;
                        });
                      },
                      onSubmitted: (text) {
                        selectedFilters.add(text);
                        pressedFilters.add('company=$text');

                        setState(() {
                          showCompanySearchField = false;
                        });
                      },
                    ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: selectedFilters.map((filter) {
                      return Chip(
                        label: Text(filter),
                        onDeleted: () {
                          setState(() {
                            pressedFilters.removeWhere(
                                (item) => item.contains('=$filter'));
                            selectedFilters.remove(filter);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print(
                          "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEER");
                      print(pressedFilters);
                      print(selectedFilters);
                      String combinedFilters = pressedFilters.join('&');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultsPage(combinedFilters: combinedFilters),
                        ),
                      );
                    },
                    child: Text('Search'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFacultyOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            'Faculty of Arts',
            'Faculty of Science',
            'Faculty of Engineering'
          ].map((faculty) {
            return ListTile(
              title: Text(faculty),
              onTap: () {
                selectedFilters.add(faculty);
                pressedFilters.add('faculty=$faculty');
                setState(() {});
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showMajorOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: majors.map((major) {
            return ListTile(
              title: Text(major),
              onTap: () {
                selectedFilters.add(major);
                pressedFilters.add('major=$major');
                setState(() {});
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserCard(
      Map<String, dynamic> user, AsyncSnapshot<String> snapshot) {
    final email = user['email'] ?? 'No email';
    final imageUrl = snapshot.data ?? '';

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PublicProfilePage(email: email),
        //   ),
        // );
      },
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          width: 160,
          child: Column(
            children: [
              imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        imageUrl,
                        height: 60,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 120,
                    ),
              SizedBox(height: 8),
              Text(user['username'] ?? 'No username'),
              SizedBox(height: 4),
              Text(email),
              SizedBox(height: 4),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        senderEmail: sEmail,
                        receiverEmail: email,
                      ),
                    ),
                  );
                },
                child: Text('Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
