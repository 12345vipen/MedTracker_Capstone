import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'cart_decoration.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";
  final DBref = FirebaseDatabase.instance.reference();

  _CartScreenState() {
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
              backgroundColor: Colors.teal,
              title: Text("Cart",
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
                        return CartDecoration(
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
