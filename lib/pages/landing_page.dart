import 'package:flutter/material.dart';
import 'package:car_parking/util.dart';

class LandingPage extends StatefulWidget {
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      drawer: MyDrawer(),
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(),
            margin: EdgeInsets.symmetric(),
            child: Card(
              color: Colors.white,
              shadowColor: Colors.white,
              elevation: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      child: Center(
                    child: Text(
                      "Welcome to Smart parking System\n\nLogin or Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  MaterialButton(
                      color: Colors.green,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
