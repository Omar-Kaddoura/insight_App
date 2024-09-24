import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final storage = FlutterSecureStorage();
  Future<void> initializeFCM() async {
    
    // Request permission for iOS devices
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Generate the FCM token
      String? token = await _firebaseMessaging.getToken();
      print("FCM Token: $token");

      // Save the token to your backend or handle it as needed
      if (token != null) {
        await saveFcmTokenToBackend(token);
      }
    } else {
      print('User declined or has not accepted permission');
    }

    // Listen for token refreshes
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print("New FCM Token: $newToken");
      await saveFcmTokenToBackend(newToken);
    });
  }
  Future<String?> getUserEmail() async {
        return await storage.read(key: 'email'); // Replace 'userEmail' with the key you used to store it
      }

  Future<void> saveFcmTokenToBackend(String token) async {
    final userEmail = getUserEmail();
    if (userEmail != null) {
    final response = await http.post(
      Uri.parse('http://10.169.31.71:5000/api/users/updateFcmToken'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userEmail': userEmail,
        'fcmToken': token,
      }),
    );

    if (response.statusCode == 200) {
      print('FCM token stored successfully');
    } else {
      print('Failed to store FCM token');
    }
  } else {
    print('User email not found');
  }
    print('Saving FCM Token to backend...');
  }
}
