import 'package:flutter/material.dart';
import 'results_page.dart'; // Import your results page
import 'PublicProfilePage.dart';

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
  String? selectedFaculty;
  String? selectedMajor;
  String? companySearchQuery;
  String? selectedStatus;
  bool showCompanySearchField = false;

  Set<String> selectedFilters = {};
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
  List<Map<String, String>> profiles = [
    {'name': 'Alice Johnson', 'major': 'Computer Science', 'company': 'TechCorp', 'status': 'Undergrad', 'faculty': 'FAFS'},
    {'name': 'Bob Smith', 'major': 'Electrical Engineering', 'company': 'ElectroInc', 'status': 'Grad', 'faculty': 'FAS'},
    {'name': 'Carol White', 'major': 'Mechanical Engineering', 'company': 'MechSolutions', 'status': 'Alumnus', 'faculty': 'FHS'},
    {'name': 'David Brown', 'major': 'Civil Engineering', 'company': 'BuildIt', 'status': 'Undergrad', 'faculty': 'FM'},
    {'name': 'Eve Davis', 'major': 'Chemical Engineering', 'company': 'ChemTech', 'status': 'Grad', 'faculty': 'HSON'},
    {'name': 'Frank Miller', 'major': 'Computer Science', 'company': 'CodeWorks', 'status': 'Alumnus', 'faculty': 'MSFEA'},
    {'name': 'Grace Lee', 'major': 'Electrical Engineering', 'company': 'PowerGrid', 'status': 'Undergrad', 'faculty': 'OSB'},
    {'name': 'Hank Wilson', 'major': 'Mechanical Engineering', 'company': 'MachineryCo', 'status': 'Grad', 'faculty': 'FAFS'},
    {'name': 'Ivy Taylor', 'major': 'Civil Engineering', 'company': 'StructureBuilders', 'status': 'Alumnus', 'faculty': 'FAS'},
    {'name': 'Jack Anderson', 'major': 'Chemical Engineering', 'company': 'ReactorsLtd', 'status': 'Undergrad', 'faculty': 'FHS'},
    {'name': 'Karen Thomas', 'major': 'Computer Science', 'company': 'DevHouse', 'status': 'Grad', 'faculty': 'FM'},
    {'name': 'Leo Martinez', 'major': 'Electrical Engineering', 'company': 'CircuitDesign', 'status': 'Alumnus', 'faculty': 'HSON'},
    {'name': 'Mona Garcia', 'major': 'Mechanical Engineering', 'company': 'EngineMasters', 'status': 'Undergrad', 'faculty': 'MSFEA'},
    {'name': 'Nate Robinson', 'major': 'Civil Engineering', 'company': 'CivilWorks', 'status': 'Grad', 'faculty': 'OSB'},
    {'name': 'Olivia Clark', 'major': 'Chemical Engineering', 'company': 'ChemicalsInc', 'status': 'Alumnus', 'faculty': 'FAFS'},
    // Add more profiles as needed
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
                      _buildProfileCard('assets/images/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A', showMessageButton: true),
                      _buildProfileCard('assets/images/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B', showMessageButton: true),
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
                      // Logic to search by name in the database
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: null,
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
                        if (value != null) {
                          if (value.contains("Faculty")) {
                            _showFacultyOptions();
                          } else if (value.contains("Major")) {
                            _showMajorOptions();
                          } else if (value.contains("Company")) {
                            showCompanySearchField = true;
                          } else if (value.contains("Undergrad")) {
                            selectedFilters.add("Undergrad");
                          } else if (value.contains("Grad")) {
                            selectedFilters.add("Grad");
                          } else if (value.contains("Alumnus")) {
                            selectedFilters.add("Alumnus");
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
                            selectedFilters.remove(filter);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(
                            filters: {
                              'status': selectedFilters.contains("Undergrad") ? "Undergrad" :
                              selectedFilters.contains("Grad") ? "Grad" :
                              selectedFilters.contains("Alumnus") ? "Alumnus" : null,
                              'faculty': selectedFaculty,
                              'major': selectedMajor,
                              'company': companySearchQuery,
                            },
                          ),
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
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildProfileCard(String imagePath, String name, String major, String company, {bool showMessageButton = false}) {
    return InkWell(
      onTap: () {
        // Navigate to another page when the card is tapped
        Navigator.push(
          context,          //TODO: open the page for the specific user, the following public profile page is only for one user
          MaterialPageRoute(builder: (context) => PublicProfilePage()),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(imagePath, height: 100, width: 100),
            Text(name),
            Text(major),
            Text(company),
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
}
