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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Horizontal Profile Panel
                  Container(
                    height: 225, // Adjust height if needed
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildProfileCard('assets/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A'),
                        _buildProfileCard('assets/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B'),
                        _buildProfileCard('assets/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A'),
                        _buildProfileCard('assets/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B'),
                        _buildProfileCard('assets/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A'),
                        _buildProfileCard('assets/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B'),
                        _buildProfileCard('assets/profileUser.jpg', 'John Doe', 'Major in CS', 'Company A'),
                        _buildProfileCard('assets/profileUser.jpg', 'Jane Smith', 'Major in EE', 'Company B'),
                        // Add more profiles as needed
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

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
                      });
                    },
                    hint: Text("Filter Settings"),
                    underline: Container(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: _onChatButtonPressed,
                child: Icon(Icons.chat),
                backgroundColor: Color.fromARGB(255, 0, 94, 132), // Match your theme color
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChatButtonPressed() {
    // Add your chat button logic here
    print('Chat button pressed');
  }

  Widget _buildProfileCard(String imagePath, String name, String major, String company) {
    return Container(
      width: 160, // Adjust width if needed
      margin: EdgeInsets.only(right: 16), // Spacing between cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50, // Adjust radius if needed
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(major),
          Text(company),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Logic for "message" button
            },
            child: Text('Message'),
          ),
        ],
      ),
    );
  }
}
