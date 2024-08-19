// profile_page.dart

import 'package:flutter/material.dart';
import 'AccountSettingsPage.dart'; // Import the AccountSettingsPage file
 import 'AppSettingsPage.dart'; // Import the AppSettingsPage file
 import 'HelpPage.dart'; // Import the HelpPage file

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120, // Increase the AppBar height if needed
        title: Center(
          child: Text(
            "My Account",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 94, 132),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow if necessary
      ),
      body: Column(
        children: [
          SizedBox(height: 40), // Add space below the AppBar
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/defaultProfile.JPG'),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Account Settings",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 94, 132),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountSettingsPage()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "App Settings",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 94, 132),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppSettingsPage()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text(
                    "Help",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 94, 132),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
