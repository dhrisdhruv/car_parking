import 'package:flutter/material.dart';
import 'package:car_parking/pages/your_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
                      Navigator.pushNamed(context, '/');
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
      title: Text("Smart Car Parking System"),
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
