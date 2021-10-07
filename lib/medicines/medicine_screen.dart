import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add_medicine.dart';
import 'medicine_decoration.dart';

class MedicineScreen extends StatefulWidget {
  String name;
  String phoneNo;

  MedicineScreen({Key? key, required this.name, required this.phoneNo})
      : super(key: key);

  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";
  final DBref = FirebaseDatabase.instance.reference();

  _MedicineScreenState() {
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
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  Text(widget.name,
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                ],
              ),
              actions: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMedicine(
                              userId: userId,
                              patientId: widget.name + " " + widget.phoneNo),
                        ));
                  },
                  child: Row(
                    children: [
                      Center(
                          child: Text(
                            "Add Medicines",
                            style: TextStyle(fontSize: 18),
                          )),
                      SizedBox(width: 8,),
                      Icon(Icons.create),
                      SizedBox(width: 5,),
                    ],
                  ),
                ),
              ],
            ),
            body: SafeArea(
                child: FirebaseAnimatedList(
              query: DBref.child(userId).child("Medicines").child(widget.name+" "+widget.phoneNo),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return MedicineDecoration(
                  name: snapshot.value["name"],
                  time: snapshot.value["time"],
                  quantity: snapshot.value["quantity"],
                  patientId: widget.name + " " + widget.phoneNo,
                  index: index,
                  userId: userId,
                );
              },
            )),
          );
  }

  Future<String> getId() async {
    final user = await FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}

// save

// StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance
//     .collection("MedTracker")
// .doc(userId)
// .collection(widget.name + " " + widget.phoneNo)
// .snapshots(),
// builder: (BuildContext context, snapshot) {
// int countId = snapshot.data?.docs.length??0;
// if (countId==0) {
// return SingleChildScrollView(
// child: Container(
// margin: EdgeInsets.all(10),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// SizedBox(height:100),
// Text("Nothing Added Yet!",style: TextStyle(color: Colors.blue,fontSize: 22),),
// SizedBox(height:10),
// Text("Click on Add Medicines button on top."),
// SizedBox(height:100),
// Center(child: CircularProgressIndicator()),
// ],
// )),
// );
// }
// return ListView.builder(
// itemBuilder: (context, index) {
// Map<String,dynamic> document = snapshot.data!.docs[index].data() as Map<String,dynamic>;
// String result="hello";
// FirebaseDatabase.instance
//     .reference()
//     .child(userId).child(widget.name + " " + widget.phoneNo).child(document["name"])
//     .once()
//     .then((snapshot){result=snapshot.value['quantity'].toString();});
// print(result);
// return MedicineDecoration(
// name:document["name"],
// time:document["time"],
// quantity:document["quantity"],
// patientId:widget.name + " " + widget.phoneNo,
// index:index,
// userId:userId,
// medDocs:snapshot.data!.docs,
// );
// },
// itemCount: snapshot.data!.docs.length,
// );
// },
// ),
