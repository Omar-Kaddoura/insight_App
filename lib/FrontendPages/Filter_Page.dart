import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 0, 94, 132),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 57, 199, 149),
        ),
      ),
      home: FilterPage(),
    );
  }
}

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedFilter;
  String? selectedFaculty;
  String? selectedMajor;
  String? companySearchQuery;
  String? selectedStatus;
  String nameSearchQuery = '';
  bool showCompanySearchField = false;

  List<Map<String, String>> profiles = [
    {
      'name': 'Alice Green',
      'major': 'Computer Science',
      'company': 'Tech Corp',
      'faculty': 'MSFEA',
      'status': 'Undergrad',
    },
    {
      'name': 'Bob White',
      'major': 'Computer Science',
      'company': 'Innovate Inc',
      'faculty': 'MSFEA',
      'status': 'Grad',
    },
    {
      'name': 'Carol Blue',
      'major': 'Electrical and Computer Engineering',
      'company': 'ElectroTech',
      'faculty': 'MSFEA',
      'status': 'Alumnus',
    },
    {
      'name': 'David Black',
      'major': 'Electrical and Computer Engineering',
      'company': 'Tech Solutions',
      'faculty': 'MSFEA',
      'status': 'Undergrad',
    },
    // Add more profiles as needed
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? Row(
                    children: [
                      _buildProfileCard('assets/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A', showMessageButton: true),
                      _buildProfileCard('assets/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B', showMessageButton: true),
                    ],
                  )
                      : SizedBox(width: 0);
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
                      setState(() {
                        nameSearchQuery = text;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedFilter,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(value: "Search by Faculty", child: Text("Search by Faculty")),
                      DropdownMenuItem(value: "Search by Major", child: Text("Search by Major")),
                      DropdownMenuItem(value: "Search by Undergrad", child: Text("Search by Undergrad")),
                      DropdownMenuItem(value: "Search by Grad", child: Text("Search by Grad")),
                      DropdownMenuItem(value: "Search by Alumnus", child: Text("Search by Alumnus")),
                      DropdownMenuItem(value: "Search by Company", child: Text("Search by Company")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                        selectedFaculty = null;
                        selectedMajor = null;
                        selectedStatus = null;
                        companySearchQuery = null;
                        showCompanySearchField = value == "Search by Company";
                        if (selectedFilter == "Search by Faculty") {
                          _showFacultyOptions();
                        } else if (selectedFilter == "Search by Major") {
                          _showMajorOptions();
                        } else if (selectedFilter == "Search by Undergrad" || selectedFilter == "Search by Grad" || selectedFilter == "Search by Alumnus") {
                          _setSelectedStatus(selectedFilter!);
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
                        setState(() {
                          showCompanySearchField = false;
                        });
                      },
                    ),
                  SizedBox(height: 20),
                  if (selectedFaculty != null)
                    SizedBox(height: 400, child: _buildProfileGrid(_filterProfilesByFaculty(selectedFaculty!))),
                  if (selectedMajor != null)
                    SizedBox(height: 400, child: _buildProfileGrid(_filterProfilesByMajor(selectedMajor!))),
                  if (selectedStatus != null)
                    SizedBox(height: 400, child: _buildProfileGrid(_filterProfilesByStatus(selectedStatus!))),
                  if (companySearchQuery != null && companySearchQuery!.isNotEmpty)
                    SizedBox(height: 400, child: _buildProfileGrid(_filterProfilesByCompany(companySearchQuery!))),
                  if (nameSearchQuery.isNotEmpty)
                    SizedBox(height: 400, child: _buildProfileGrid(_filterProfilesByName(nameSearchQuery))),
                  if (nameSearchQuery.isEmpty && selectedFilter == null && selectedFaculty == null && selectedMajor == null && selectedStatus == null && companySearchQuery == null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text('No filters applied. Please select a filter.'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onChatButtonPressed,
        child: Icon(Icons.chat),
        backgroundColor: Color.fromARGB(255, 0, 94, 132),
      ),
    );
  }

  void _onChatButtonPressed() {
    print('Chat button pressed');
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
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _setSelectedStatus(String filter) {
    setState(() {
      selectedStatus = filter.split(' ')[2];
    });
  }

  List<Map<String, String>> _filterProfilesByFaculty(String faculty) {
    return profiles.where((profile) => profile['faculty'] == faculty).toList();
  }

  List<Map<String, String>> _filterProfilesByMajor(String major) {
    return profiles.where((profile) => profile['major'] == major).toList();
  }

  List<Map<String, String>> _filterProfilesByStatus(String status) {
    return profiles.where((profile) => profile['status'] == status).toList();
  }

  List<Map<String, String>> _filterProfilesByCompany(String company) {
    return profiles.where((profile) => profile['company']!.toLowerCase().contains(company.toLowerCase())).toList();
  }

  List<Map<String, String>> _filterProfilesByName(String name) {
    return profiles.where((profile) => profile['name']!.toLowerCase().contains(name.toLowerCase())).toList();
  }

  ListTile _buildFacultyOption(String faculty) {
    return ListTile(
      title: Text(faculty),
      onTap: () {
        setState(() {
          selectedFaculty = faculty;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildProfileCard(String imagePath, String name, String major, String company, {bool showMessageButton = false}) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(major, style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
          Text(company, style: TextStyle(fontSize: 16)),
          if (showMessageButton)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Message'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileGrid(List<Map<String, String>> profiles) {
    if (profiles.isEmpty) {
      return Center(child: Text('No profiles found.'));
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return _buildProfileCard(
          'assets/profileUser.jpg',
          profiles[index]['name']!,
          profiles[index]['major']!,
          profiles[index]['company']!,
          showMessageButton: true,
        );
      },
    );
  }
}
