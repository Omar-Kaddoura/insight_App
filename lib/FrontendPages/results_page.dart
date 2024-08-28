import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final Map<String, dynamic> filters;

  ResultsPage({required this.filters});

  @override
  Widget build(BuildContext context) {
    // Filter profiles based on the provided filters
    List<Map<String, String>> filteredProfiles = _applyFilters();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                // Handle search by name
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
                itemCount: filteredProfiles.length,
                itemBuilder: (context, index) {
                  return _buildProfileCard(
                    'assets/images/profileUser.jpg', // Use actual image path
                    filteredProfiles[index]['name']!,
                    filteredProfiles[index]['major']!,
                    filteredProfiles[index]['company']!,
                    showMessageButton: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _applyFilters() {
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

    return profiles.where((profile) {
      bool matches = true;
      if (filters['faculty'] != null) {
        matches &= profile['faculty'] == filters['faculty'];
      }
      if (filters['major'] != null) {
        matches &= profile['major'] == filters['major'];
      }
      if (filters['status'] != null) {
        matches &= profile['status'] == filters['status'];
      }
      if (filters['company'] != null) {
        matches &= profile['company']!.toLowerCase().contains(filters['company']!.toLowerCase());
      }
      return matches;
    }).toList();

  }

  Widget _buildProfileCard(String imagePath, String name, String major, String company, {bool showMessageButton = false}) {
    return Card(
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
    );
  }
}
