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
  String? companySearchQuery; // New variable for company search input
  bool showCompanySearchField = false; // Flag to show/hide company search field

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

  Map<String, List<Map<String, String>>> majorProfiles = {
    'Computer Science': [
      {'name': 'Alice Green', 'major': 'Computer Science', 'company': 'Tech Corp'},
      {'name': 'Bob White', 'major': 'Computer Science', 'company': 'Innovate Inc'},
      // Add more profiles as needed
    ],
    'Electrical and Computer Engineering': [
      {'name': 'Carol Blue', 'major': 'Electrical and Computer Engineering', 'company': 'ElectroTech'},
      {'name': 'David Black', 'major': 'Electrical and Computer Engineering', 'company': 'Tech Solutions'},
      // Add more profiles as needed
    ],
    // Add other majors and their profiles here
  };

  Map<String, List<Map<String, String>>> companyProfiles = {
    'Tech Corp': [
      {'name': 'Alice Green', 'major': 'Computer Science', 'company': 'Tech Corp'},
    ],
    'ElectroTech': [
      {'name': 'Carol Blue', 'major': 'Electrical and Computer Engineering', 'company': 'ElectroTech'},
    ],
    // Add other companies and their profiles here
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Horizontal Profile Panel
            Container(
              height: 250, // Adjust height if needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8, // Adjust according to the number of profile cards
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return Row(
                      children: [
                        _buildProfileCard('assets/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A', showMessageButton: true),
                        _buildProfileCard('assets/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B', showMessageButton: true),
                      ],
                    );
                  } else {
                    return SizedBox(width: 0); // Empty space for alignment
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search by Name Section
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (text) {
                      // Logic to search by name in the database
                    },
                  ),
                  SizedBox(height: 20),
                  // Filter Settings Dropdown Menu
                  DropdownButton<String>(
                    value: selectedFilter,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: "Search by Faculty",
                        child: Text("Search by Faculty"),
                      ),
                      DropdownMenuItem(
                        value: "Search by Major",
                        child: Text("Search by Major"),
                      ),
                      DropdownMenuItem(
                        value: "Search by Undergrad",
                        child: Text("Search by Undergrad"),
                      ),
                      DropdownMenuItem(
                        value: "Search by Grad",
                        child: Text("Search by Grad"),
                      ),
                      DropdownMenuItem(
                        value: "Search by Company",
                        child: Text("Search by Company"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                        selectedFaculty = null; // Reset the selected faculty when a new filter is chosen
                        selectedMajor = null; // Reset the selected major when a new filter is chosen
                        companySearchQuery = null; // Reset the company search query
                        showCompanySearchField = value == "Search by Company"; // Show search field only if selected filter is "Search by Company"
                        if (selectedFilter == "Search by Faculty") {
                          _showFacultyOptions();
                        } else if (selectedFilter == "Search by Major") {
                          _showMajorOptions();
                        }
                      });
                    },
                    hint: Text("Filter Settings"),
                    underline: Container(),
                  ),
                  SizedBox(height: 20),
                  // Company Search TextField
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
                  // Display profiles based on the selected faculty
                  if (selectedFaculty != null)
                    SizedBox(
                      height: 400, // Adjust the height accordingly
                      child: _buildFacultyProfileGrid(selectedFaculty!),
                    ),
                  // Display profiles based on the selected major
                  if (selectedMajor != null)
                    SizedBox(
                      height: 400, // Adjust the height accordingly
                      child: _buildMajorProfileGrid(selectedMajor!),
                    ),
                  // Display profiles based on the company search query
                  if (companySearchQuery != null && companySearchQuery!.isNotEmpty)
                    SizedBox(
                      height: 400, // Adjust the height accordingly
                      child: _buildCompanyProfileGrid(companySearchQuery!),
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
        backgroundColor: Color.fromARGB(255, 0, 94, 132), // Match your theme color
      ),
    );
  }

  void _onChatButtonPressed() {
    // Add your chat button logic here
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
                Navigator.pop(context); // Close the bottom sheet
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
          selectedMajor = null; // Clear major when faculty is selected
        });
        Navigator.pop(context); // Close the bottom sheet
      },
    );
  }

  Widget _buildFacultyProfileGrid(String faculty) {
    // Dummy data for profiles based on the selected faculty
    List<Map<String, String>> profiles = [
      {'name': 'John Doe', 'major': 'Major in CS', 'company': 'Company A'},
      {'name': 'Jane Smith', 'major': 'Major in EE', 'company': 'Company B'},
      {'name': 'Alice Johnson', 'major': 'Major in Math', 'company': 'Company C'},
      {'name': 'Bob Brown', 'major': 'Major in Physics', 'company': 'Company D'},
      {'name': 'John Doe', 'major': 'Major in CS', 'company': 'Company A'},
      {'name': 'Jane Smith', 'major': 'Major in EE', 'company': 'Company B'},
      {'name': 'Alice Johnson', 'major': 'Major in Math', 'company': 'Company C'},
      {'name': 'Bob Brown', 'major': 'Major in Physics', 'company': 'Company D'},
      {'name': 'John Doe', 'major': 'Major in CS', 'company': 'Company A'},
      {'name': 'Jane Smith', 'major': 'Major in EE', 'company': 'Company B'},
      {'name': 'Alice Johnson', 'major': 'Major in Math', 'company': 'Company C'},
      {'name': 'Bob Brown', 'major': 'Major in Physics', 'company': 'Company D'},
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two profiles per row
        crossAxisSpacing: 6, // Reduce spacing between cards horizontally
        mainAxisSpacing: 10, // Reduce spacing between cards vertically
        childAspectRatio: 0.72, // Adjust aspect ratio for vertical space
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

  Widget _buildMajorProfileGrid(String major) {
    List<Map<String, String>> profiles = majorProfiles[major] ?? [];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two profiles per row
        crossAxisSpacing: 6, // Reduce spacing between cards horizontally
        mainAxisSpacing: 10, // Reduce spacing between cards vertically
        childAspectRatio: 0.72, // Adjust aspect ratio for vertical space
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

  Widget _buildCompanyProfileGrid(String company) {
    List<Map<String, String>> profiles = companyProfiles[company] ?? [];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two profiles per row
        crossAxisSpacing: 6, // Reduce spacing between cards horizontally
        mainAxisSpacing: 10, // Reduce spacing between cards vertically
        childAspectRatio: 0.72, // Adjust aspect ratio for vertical space
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

  Widget _buildProfileCard(String imagePath, String name, String major, String company, {bool showMessageButton = true}) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: EdgeInsets.all(4.0), // Reduce padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 4,
                  child: CircleAvatar(
                    radius: constraints.maxHeight * 0.23, // Adjust avatar size
                    backgroundImage: AssetImage(imagePath),
                  ),
                ),
                SizedBox(height: 3), // Adjust space between elements
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Name
                      Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                      // Major
                      Text(
                        major,
                        style: TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                      // Company
                      Text(
                        company,
                        style: TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                    ],
                  ),
                ),
                if (showMessageButton)
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0), // Adjust padding for button
                      child: ElevatedButton(
                        onPressed: () {
                          // Logic for "message" button
                        },
                        child: Text('Message', style: TextStyle(fontSize: 11)),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
