import 'dart:convert';
import 'package:flutter/material.dart';
import 'PublicProfilePage.dart';
import 'results_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final storage = FirebaseStorage.instance;
  final _storage = FlutterSecureStorage();

  String? selectedFaculty;
  String? selectedMajor;
  String? companySearchQuery;
  bool showCompanySearchField = false;
  Set<String> selectedFilters = {};
  Set<String> pressedFilters = {};

  List<String> majors = [
    'Agri-Business', 'Agri-culture', 'Applied Mathematics', 'Arabic', 'Archaeology',
    'Architecture', 'Art History', 'Biology', 'Business Administration', 'Chemical Engineering',
    'Chemistry', 'Civil and Environmental Engineering', 'Computer and Communications Engineering',
    'Computer Science', 'Construction Engineering', 'Earth Sciences', 'Electrical and Computer Engineering',
    'Elementary Education', 'English Language', 'English Literature', 'Environmental Health',
    'Food Sciences and Management', 'Graphic Design', 'Health Communication', 'History',
    'Industrial Engineering', 'Landscape Architecture (BLA)', 'Mathematics', 'Mechanical Engineering',
    'Media and Communication', 'Medical Imaging Sciences', 'Medical Laboratory Sciences', 'Nursing',
    'Nutrition and Dietetics', 'Philosophy', 'Physics', 'Political Studies', 'Psychology',
    'Public Administration', 'Sociology-Anthropology', 'Statistics', 'Studio Arts'
  ];

  List<dynamic> _profiles = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
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

  Future<void> _fetchUsers() async {
    final email = await _storage.read(key: 'email');
    if (email == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'User email is not available';
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://10.169.29.139:5000/api/users/usersByFilter?email=$email&cabinet=yes'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            _profiles = data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Unexpected data format';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load users';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching users: $e';
      });
    }
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
                    onChanged: (text) {
                    
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: null,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: "Search by Faculty", child: Text("Search by Faculty")),
                      DropdownMenuItem(value: "Search by Major", child: Text("Search by Major")),
                      DropdownMenuItem(value: "Search by Undergrad", child: Text("Search by Undergrad")),
                      DropdownMenuItem(value: "Search by Grad", child: Text("Search by Grad")),
                      DropdownMenuItem(value: "Search by PHD", child: Text("Search by PHD")),
                      DropdownMenuItem(value: "Search by Company", child: Text("Search by Company")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          if (value.contains("Faculty")) {
                            _showFacultyOptions();
                          } else if (value.contains("Major")) {
                            _showMajorOptions();
                          } else if (value.contains("Company")) {
                            showCompanySearchField = true;
                          } else if (value.contains("Undergrad")) {
                            selectedFilters.add("Undergrad");
                            pressedFilters.add('studies=Undergraduate');
                          } else if (value.contains("Grad")) {
                            selectedFilters.add("Grad");
                            pressedFilters.add('stduies=Graduate');
                          } else if (value.contains("PHD")) {
                            selectedFilters.add("PHD");
                            pressedFilters.add('studies=PHD');
                          }
                        }
                      });
                    },
                    hint: Text("Filter Settings"),
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
                            pressedFilters.removeWhere((item) => item.contains('=$filter'));
                            selectedFilters.remove(filter);
                            
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print(pressedFilters);
                      print(selectedFilters);
                      String combinedFilters = pressedFilters.join('&');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(combinedFilters: combinedFilters,),
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
          padding: EdgeInsets.all(16),
          children: [
            _buildFacultyOption('FAFS'),
            _buildFacultyOption('FAS'),
            _buildFacultyOption('FHS'),
            _buildFacultyOption('FM'),
            _buildFacultyOption('HSON'),
            _buildFacultyOption('MSFEA'),
            _buildFacultyOption('OSB'),
          ],
        );
      },
    );
  }

  void _showMajorOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          padding: EdgeInsets.all(16),
          children: majors.map((major) {
            return ListTile(
              title: Text(major),
              onTap: () {
                setState(() {
                  selectedMajor = major;
                  pressedFilters.add('major=$major');
                  selectedFilters.add(major);
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFacultyOption(String faculty) {
    return ListTile(
      title: Text(faculty),
      onTap: () {
        setState(() {
          selectedFaculty = faculty;
          selectedFilters.add(faculty);
          pressedFilters.add('faculty=$faculty');
        });
        Navigator.pop(context);
      },
    );
  }

  // Widget _buildProfileCard(String imagePath, String name, String major, String company, {bool showMessageButton = false}) {
  //   return InkWell(
  //     onTap: () {
  //       // Navigate to another page when the card is tapped
  //       Navigator.push(
  //         context,          //TODO: open the page for the specific user, the following public profile page is only for one user
  //         MaterialPageRoute(builder: (context) => PublicProfilePage()),
  //       );
  //     },
  //     child: Card(
  //       child: Column(
  //         children: [
  //           Image.asset(imagePath, height: 200, width: 200),
  //           Text(name),
  //           Text(major),
  //           Text(company),
  //           if (showMessageButton)
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Handle message button press
  //               },
  //               child: Text('Message'),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildUserCard(Map<String, dynamic> user, AsyncSnapshot<String> snapshot) {
  final imageUrl = snapshot.data ?? ''; // Default to empty string if image URL is not yet available

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    elevation: 7.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 55.0,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.grey[200],
          ),

          SizedBox(height: 2.0),
          Text(
            user['username'] ?? 'Unknown User',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Text(
            user['email'] ?? 'No email',
            style: TextStyle(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          // SizedBox(height: 1.0),
          ElevatedButton(
            onPressed: (){

            },
             child: Text('Message'),
             ),
        ],
      ),
    ),
  );
}

}