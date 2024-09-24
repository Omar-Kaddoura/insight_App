import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
   String sanitizeEmail(String? email) {
    return email!.replaceAll('.', '_');
  }
  
  String generateChatroomId(String? senderEmail, String receiverEmail) {
    List<String> emails = [sanitizeEmail(senderEmail), sanitizeEmail(receiverEmail)];
    emails.sort(); 
    return emails.join();
  }
  void sendMessage(String? senderEmail, String receiverEmail, String message) {
    String chatroomId = generateChatroomId(senderEmail, receiverEmail);
    DatabaseReference chatroomRef = FirebaseDatabase.instance
        .ref()
        .child("chatrooms")
        .child(chatroomId)
        .push(); 
    chatroomRef.set({
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    }).then((_) {
      print('Message sent to chatroom $chatroomId successfully');
    }).catchError((error) {
      print('Failed to send message: $error');
    });
  }
  void fetchMessages(String? senderEmail, String receiverEmail) {
    String chatroomId = generateChatroomId(senderEmail, receiverEmail); 
    DatabaseReference chatroomRef = FirebaseDatabase.instance
        .ref()
        .child("chatrooms")
        .child(chatroomId);
    chatroomRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> messages = snapshot.value as Map<dynamic, dynamic>;
        messages.forEach((key, value) {
          print("Message from ${value['senderEmail']} to ${value['receiverEmail']}: ${value['message']}");
        });
      } else {
        print("No messages in this chatroom yet.");
      }
    });
  }
}
