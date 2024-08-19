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
          selectedItemColor: Colors.white, // Change the selected icon color to white
          unselectedItemColor: Color.fromARGB(255, 57, 199, 149), // Change the unselected icon color
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
  String? selectedFilter; // Set to null initially
  int _selectedIndex = 0; // Add state for the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
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
              value: selectedFilter, // Initially null
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
                  // Logic to apply the filter
                });
              },
              hint: Text("Filter Settings"),
              underline: Container(),
            ),
          ],
        ),
      ),
     );
  }
}
