import 'package:flutter/material.dart';
import 'package:car_parking/util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
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
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            keyboardType: TextInputType.visiblePassword,
            onChanged: (text) {
              password = text;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (email == null ||
                  email == "" ||
                  password == null ||
                  password == "") {
                return;
              } else {
                final User? user = (await _auth.signInWithEmailAndPassword(
                    email: email, password: password)).user;
                if(user!=null) {
                  Navigator.pushNamed(context, '/homepage');
                }
                else
                  {
                    return;
                  }
              }
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
