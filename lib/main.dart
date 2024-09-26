import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Pages/Authentication/register_page.dart';
import 'Pages/Authentication/login_page.dart';
import 'Pages/Authentication/WelcomePage.dart';
import 'Admin/AdminBottomNavigationBarPages/Admin_home.dart';
import 'BottomNavigationBarPages/home_with_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'api/firebase_api.dart';
import 'package:insight/BottomNavigationBarPages/Social/messaging/fcm_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  FcmService().initializeFCM();
  
  
  // Initialize secure storage
  final _storage = FlutterSecureStorage();

  // Check if token and user type exist
  final token = await _storage.read(key: 'jwt');
  final type = await _storage.read(key: 'type');

  // Determine the initial route based on the presence of token and user type
  String initialRoute = '/';
  if (token != null && type != null) {
    initialRoute = type == 'Admin' ? '/admin_home' : '/student_home';
  }
  runApp(MyApp(initialRoute: initialRoute));
}
class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insight App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/student_home': (context) => const HomePageWithNavigation(),
        '/admin_home': (context) => const AdminHome(),
      },
    );
  }
}