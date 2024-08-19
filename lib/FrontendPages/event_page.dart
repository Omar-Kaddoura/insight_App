import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'up_logo.dart'; // Import the custom app bar

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(), // Use the custom app bar
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 132),
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: Text(
                'Event Title',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 132),
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                image: DecorationImage(
                  image: AssetImage('assets/images/event.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: screenWidth * 0.5,
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Text(
                  '2024-07-10',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color:  Color.fromARGB(255, 0, 94, 132),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: Text(
                'Event Description: This is the description box.',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Color.fromARGB(255, 0, 94, 132),

                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
