import 'package:car_parking/pages/home_page.dart';
import 'package:car_parking/pages/login_page.dart';
import 'package:car_parking/pages/your_booking.dart';
import 'package:flutter/material.dart';
import './pages/landing_page.dart';
import 'package:car_parking/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: LandingPage(),
        title: const Text(
          "Smart Car Parking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        loaderColor: Color.fromRGBO(255, 114, 94, 1),
        loadingText: Text(
            "Just checking free parking spots :)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        image: Image.asset("assets/splashScreen.png"),
        photoSize: 150,
        gradientBackground: RadialGradient(colors: [Colors.purple, Colors.black]),
      ),
      routes: {
        '/landing': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/yourbooking': (context) => YourBooking(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}