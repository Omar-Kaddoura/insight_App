import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        backgroundColor: Color.fromARGB(255, 0, 94, 132),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // FAQs Section
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text("Frequently Asked Questions"),
            onTap: () {
              // Navigate to FAQ details or show FAQ content
              _showFAQDialog(context);
            },
          ),
          Divider(),

          // Contact Support Section
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text("Contact Support"),
            onTap: () {
              // Show contact support dialog or navigate to contact page
              _showContactSupportDialog(context);
            },
          ),
          Divider(),

          // User Guide Section
          ListTile(
            leading: Icon(Icons.book),
            title: Text("User Guide"),
            onTap: () {
              // Open user guide
              _showUserGuideDialog(context);
            },
          ),
          Divider(),

          // Feedback Section
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text("Send Feedback"),
            onTap: () {
              // Navigate to feedback form or show feedback dialog
              _showFeedbackDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFAQDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("FAQs"),
          content: Text(
            "Here are some frequently asked questions to help you.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showContactSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Contact Support"),
          content: Text(
            "For support, please contact us at support@example.com.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showUserGuideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("User Guide"),
          content: Text(
            "Access the user guide for detailed instructions.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Send Feedback"),
          content: Text(
            "We appreciate your feedback to improve our app.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
