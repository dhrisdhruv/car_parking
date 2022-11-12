import 'package:car_parking/pages/home_page.dart';
import 'package:car_parking/pages/login_page.dart';
import 'package:car_parking/pages/your_booking.dart';
import 'package:flutter/material.dart';
import './pages/landing_page.dart';
import 'package:car_parking/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/yourbooking': (context) => YourBooking(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}