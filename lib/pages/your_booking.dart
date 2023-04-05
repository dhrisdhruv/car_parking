import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:car_parking/util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class YourBooking extends StatefulWidget {
  var index;

  YourBooking({super.key, @required this.index});

  _YourBookingState createState() => _YourBookingState(index: index);
}

class _YourBookingState extends State<YourBooking> {
  var index;
  late Query _slotQuery;
  late DatabaseReference ref;

  _YourBookingState({@required this.index});
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

  void updateState(int index) async {
    final updateRef = ref.child("slots/slot${index}/");
    await updateRef.update({
      "state": false,
      "BookingDevice": "app",
    });
  }

  @override
  initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref();
    _slotQuery = ref.child("slots").orderByChild("id");
    updateState(index);
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
                    "BookingDevice":"",
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