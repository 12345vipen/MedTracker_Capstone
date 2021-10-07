import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class Crud extends StatelessWidget {
  Crud({Key? key}) : super(key: key);

  final DBref = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD operations"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            writeData();
          },child: Text("Write Data"),),
          ElevatedButton(onPressed: (){
            readData();
          },child: Text("Read Data"),),
          ElevatedButton(onPressed: (){
            updateData();
          },child: Text("update Data"),),
          ElevatedButton(onPressed: (){
            deletData();
          },child: Text("Delete Data"),)
        ],
      ),
    );
  }
  void writeData() {
    DBref.child("1").set({
      'id':'Id1',
      'data':"This is a sample data"
    });
  }
  void readData() {
    DBref.once().then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
    });
  }
  void updateData() {
    DBref.child("1").update({
      'data':"this is updated"
    });
  }
  void deletData() {
    DBref.child("1").remove();
  }
}
