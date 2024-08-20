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
//Tried for the horz
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
//Tried, for the Search by name box
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

                        if (selectedFilter == "Search by Faculty") {
                          _showFacultyOptions();
                        }
                      });
                    },
                    hint: Text("Filter Settings"),
                    underline: Container(),
                  ),
                  SizedBox(height: 20),
//Tried, for the drop down
                  // Display profiles based on the selected faculty
                  if (selectedFaculty != null)
                    SizedBox(
                      height: 400, // Adjust the height accordingly
                      //Tries, the height of the wholl box containg the profiles
                      child: _buildFacultyProfileGrid(selectedFaculty!),
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

  Widget _buildFacultyOption(String faculty) {
    return ListTile(
      title: Text(faculty),
      onTap: () {
        setState(() {
          selectedFaculty = faculty;
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
        crossAxisSpacing: 6, // Further reduce spacing between cards horizontally
        mainAxisSpacing: 10, // Further reduce spacing between cards vertically
        childAspectRatio: 0.72, // Slightly reduce aspect ratio for more vertical space
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
            padding: EdgeInsets.all(4.0), // Reduce padding to 4.0
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 4,
                  child: CircleAvatar(
                    radius: constraints.maxHeight * 0.23, // Slightly smaller avatar
                    backgroundImage: AssetImage(imagePath),
                  ),
                ),
                SizedBox(height: 3), // Reduce space between elements
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), // Slightly smaller text
                      Text(major, style: TextStyle(fontSize: 11)), // Reduce text size
                      Text(company, style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
                if (showMessageButton)
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0), // Reduce padding for button
                      child: ElevatedButton(
                        onPressed: () {
                          // Logic for "message" button
                        },
                        child: Text('Message', style: TextStyle(fontSize: 11)), // Slightly smaller button text
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
