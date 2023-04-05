import 'package:flutter/material.dart';
import 'package:car_parking/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

late String email;
late String password;

class SignUpPage extends StatefulWidget {
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/2,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(),
              margin: EdgeInsets.symmetric(),
              child: Card(
                borderOnForeground: true,
                color: Colors.white,
                shadowColor: Colors.white,
                elevation: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height/4,
                      width: MediaQuery.of(context).size.width/4,
                      child: Image.asset("assets/splashScreen.png"),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white10,
                        labelText: 'Email',
                        hintText: 'Enter your Email ID',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        email = text;
                      },
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white10,
                        filled: true,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (text) {
                        password = text;
                      },
                    ),
                    MaterialButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (email == null ||
                            email == "" ||
                            password == null ||
                            password == "") {
                          return;
                        } else {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                      child: Text("Sign Up"),
                    )
                  ],
                ),
              ),
            ),
          ),

        ),
    );
  }
}
