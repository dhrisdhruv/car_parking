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
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your Email",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
              ),
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
              child: Text("Sign Up"),
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
            )
          ],
        ));
  }
}
