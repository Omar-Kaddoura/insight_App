import 'package:flutter/material.dart';

class PublicProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<PublicProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Overview"),
        backgroundColor: Color.fromARGB(255, 0, 94, 132),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/defaultProfile.JPG'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "John Doe",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 94, 132),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Software Engineer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            _buildExpandableSection(
              title: "Bio",
              content: "like to implement projects in software.",
              icon: Icons.info,
            ),
            _buildExpandableSection(
              title: "Contact Info",
              content: "Email: john.doe@example.com\nPhone: +1 123 456 7890",
              icon: Icons.contact_mail,
            ),
            _buildExpandableSection(
              title: "Job Details",
              content: "Title: Senior Developer\nCompany: ABC Corp\nDescription: Leading software development projects.",
              icon: Icons.work,
            ),
            _buildExpandableSection(
              title: "Social Media",
              content: "LinkedIn: linkedin.com/in/johndoe\nInstagram: @johndoe",
              icon: Icons.link,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                },
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 24,
                ),
                label: Text(
                  "Message",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 94, 132), // Button color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  shadowColor: Color.fromARGB(100, 0, 0, 0), // Shadow color
                  elevation: 5, // Shadow elevation
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ExpansionTile(
          leading: Icon(icon, color: Color.fromARGB(255, 0, 94, 132)),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 94, 132),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                content,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with John Doe"),
        backgroundColor: Color.fromARGB(255, 0, 94, 132),
      ),
      body: Stack(
        children: [
          // Background design
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildMessageBubble(
                        "Hi, how are you?",
                        isSentByUser: false,
                      ),
                      _buildMessageBubble(
                        "I'm good, thanks! How about you?",
                        isSentByUser: true,
                      ),
                      _buildMessageBubble(
                        "Just working on some projects. What about you?",
                        isSentByUser: false,
                      ),
                      _buildMessageBubble(
                        "Same here! Let’s catch up sometime.",
                        isSentByUser: true,
                      ),
                    ],
                  ),
                ),
                _buildMessageInputArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, {required bool isSentByUser}) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSentByUser ? Color.fromARGB(255, 0, 94, 132) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isSentByUser ? Radius.circular(12) : Radius.circular(0),
            bottomRight: isSentByUser ? Radius.circular(0) : Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Color.fromARGB(255, 0, 94, 132)),
            onPressed: () {
              // Handle sending message
            },
          ),
        ],
      ),
    );
  }
}
