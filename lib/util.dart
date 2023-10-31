import 'package:flutter/material.dart';
import 'package:car_parking/pages/your_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.black,
      textColor: Colors.white,
      onPressed: () async {
        final User? user = _auth.currentUser;
        if (user == null) {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text("No user logged in"),
              actions: [
                ElevatedButton(onPressed: (){}, child: Text("OK"))
              ],
            );
          });

        } else {
          await _auth.signOut();
          final String uid = user.uid;
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text("User " + uid + " is logged out !"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/landing');
                    },
                    child: Text("OK")
                )
              ],
            );
          });

        }
      },
      child: Icon(Icons.logout),
    );
  }
}





class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 200.0,
      backgroundColor: Colors.black,
      title: Text("BookMySpot System"),
      actions: [
        SignOut(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Landing Page"),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
