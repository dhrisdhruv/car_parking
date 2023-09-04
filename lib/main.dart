import 'package:car_parking/pages/home_page.dart';
import 'package:car_parking/pages/login_page.dart';
import 'package:car_parking/pages/your_booking.dart';
import 'package:flutter/material.dart';
import './pages/landing_page.dart';
import 'package:car_parking/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }

}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {



    void handleTimeout() {
      FlutterNativeSplash.remove();
    }

    Timer scheduleTimeout([int seconds = 1]) {
      return Timer(Duration(seconds: seconds), handleTimeout);
    }


    scheduleTimeout(2);


    return MaterialApp(
      home: LandingPage(),
      routes: {
        '/landing': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/yourbooking': (context) => YourBooking(index: 0,),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}