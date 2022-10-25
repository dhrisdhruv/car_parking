import 'package:car_parking/pages/your_booking.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:car_parking/util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:car_parking/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  String? userid = _auth.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: userid!=null?FreeSlots():AlertDialog(title: Text("No user logged in"),
        actions: [
          ElevatedButton(onPressed: (){}, child: Text("OK"))
        ],),
    );
  }
}

class FreeSlots extends StatefulWidget {
  _FreeSlotsState createState() => _FreeSlotsState();
}

class _FreeSlotsState extends State<FreeSlots> {
  late Query _slotQuery;
  late Query _userQuery;
  late DatabaseReference ref;
  Widget _buildSlotItem({required Map slot}) {
    bool slotState = slot["state"];
    int slotNumber = slot["id"];
    String? userid = _auth.currentUser?.uid;
    return Container(
      color: slotState ? Colors.green : Colors.red,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.car_rental),
          Text("Slot : ${slotNumber}"),
          slotState ?
            ElevatedButton(onPressed: () async {
              final updateRef = ref.child("slots/slot${slotNumber}/");
              await updateRef.update({
                "state":false,
              });
              final updateUser = ref.child("users/${userid}");
              await updateUser.update({
                "userid":userid,
                "slotid":slotNumber,
              });
              Navigator.push(context, MaterialPageRoute(builder: (context)=>YourBooking()));
            }, child: Text("Book"))
              :
            Icon(Icons.car_repair),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref();
    _slotQuery = ref.child("slots").orderByChild("id");
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(query: _slotQuery, itemBuilder: (
        BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
      Map slots = snapshot.value as Map;
      return _buildSlotItem(slot: slots);
    });
  }
}