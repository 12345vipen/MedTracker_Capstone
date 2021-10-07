
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:med_tracker/cart/cart_decoration.dart';

import 'buyer_decoration.dart';


class ChooseBuyer extends StatefulWidget {
  const ChooseBuyer({Key? key}) : super(key: key);

  @override
  _ChooseBuyerState createState() => _ChooseBuyerState();
}

class _ChooseBuyerState extends State<ChooseBuyer> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";
  final DBref = FirebaseDatabase.instance.reference();

  _ChooseBuyerState() {
    // very important if u wana change Future<String> into String
    getId().then((val) => setState(() {
      userId = val;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return (userId == "")
        ? CircularProgressIndicator()
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Choose Patient",
            style: TextStyle(color: Colors.white, fontSize: 23)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Choose member for whom you want to order!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Flexible(
              child: FirebaseAnimatedList(
                query: DBref.child(userId)
                    .child("userData"),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return BuyerDecoration(
                    name: snapshot.value["name"],
                    age: snapshot.value["age"],
                    bloodGroup: snapshot.value["bloodGroup"],
                    phoneNo: snapshot.value["phoneNo"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getId() async {
    final user = await FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}

// firestore

// StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance
//     .collection("MedTracker")
// .doc(userId)
// .collection("userData")
// .snapshots(),
// builder: (BuildContext context, snapshot) {
// int countId = snapshot.data?.docs.length??0;
// if (countId==0) {
// return Center(child: Image(image: AssetImage("assets/cartEmpty.png")));
// }
// return ListView.builder(
// shrinkWrap: true,
// itemBuilder: (context, index) {
// Map<String,dynamic> document = snapshot.data!.docs[index].data() as Map<String,dynamic>;
// return CartDecoration(
// name:document["name"],
// age:document["age"],
// bloodGroup:document["bloodGroup"],
// phoneNo:document["phoneNo"],
// );
// },
// itemCount: snapshot.data!.docs.length,
// );
// },
// ),
