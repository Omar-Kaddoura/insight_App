import 'package:flutter/material.dart';

class AppSettingsPage extends StatefulWidget {
  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Settings"),
        backgroundColor: Color.fromARGB(255, 0, 94, 132),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Notifications Setting
          SwitchListTile(
            title: Text("Enable Notifications"),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          Divider(),

          // Dark Mode Setting
          SwitchListTile(
            title: Text("Dark Mode"),
            value: _darkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            secondary: Icon(Icons.brightness_6),
          ),
          Divider(),

          // Language Setting
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text(_selectedLanguage),
            onTap: () {
              _showLanguageSelectionDialog(context);
            },
          ),
          Divider(),

          // Privacy Settings
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Privacy Settings"),
            onTap: () {
              // Add your privacy settings logic here
            },
          ),
          Divider(),

          // About
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              // Add your about page logic here
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Arabic'),
                value: 'Arabic',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              // Add more languages as needed
            ],
          ),
        );
      },
    );
  }
}
