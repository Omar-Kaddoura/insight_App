import 'package:flutter/material.dart';
import 'package:insight/FireBase/firebase_service.dart';
  

class ChatScreen extends StatefulWidget {
  final String? senderEmail;
  final String receiverEmail;

  ChatScreen({required this.senderEmail, required this.receiverEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _firebaseService.fetchMessages(widget.senderEmail, widget.receiverEmail);
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _firebaseService.sendMessage(widget.senderEmail, widget.receiverEmail, _messageController.text);
      _messageController.clear(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiverEmail}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              // Add your ListView for messages here
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Enter message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
