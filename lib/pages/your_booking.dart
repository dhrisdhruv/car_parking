import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:car_parking/util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class YourBooking extends StatefulWidget {
  YourBooking({super.key});

  _YourBookingState createState() => _YourBookingState();
}

class _YourBookingState extends State<YourBooking> {
  late String userid;
  late DatabaseReference ref;
  late final snapshot;
  late int index;
  late Query _slotQuery;
  late Map users;
  _YourBookingState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: index!=null?BookingDone(index: index,):AlertDialog(title: Text("Booking Not Done"),
        actions: [
          ElevatedButton(onPressed: (){}, child: Text("OK"))
        ],),
    );
  }
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref();
    userid = _auth.currentUser!.uid;
    snapshot = ref.child("users/${userid}").get();
    index = snapshot;

  }
}

class BookingDone extends StatelessWidget {
  int index;
  BookingDone({super.key, required this.index});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.zero,
      child: Card(
        color: Colors.green,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.done),
              title: Text("Your booking is confirmed"),
            ),
            ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text("Your slot number is $index"),
            ),
            ElevatedButton(
                onPressed: () async {
                  final path = "slots/slot${index}/";
                  final ref = FirebaseDatabase.instance.ref().child(path);
                  await ref.update({
                    "state":true,
                  });
                  Navigator.pushNamed(context, '/homepage');
                },
                child: Text("Open Gate")
            ),
          ],
        ),
      ),
    );
  }
}