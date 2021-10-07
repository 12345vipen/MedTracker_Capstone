import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateId extends StatefulWidget {
  @override
  _CreateIdState createState() => _CreateIdState();
}

class _CreateIdState extends State<CreateId> {
  final DBref = FirebaseDatabase.instance.reference();
  int intialValue = 25;
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId="";
  _CreateIdState() {
    // very important if u wana change Future<String> into String
    getId().then((val) => setState(() {
      userId = val;
    }));
  }
  var _enteredName = '';
  var _enteredPhoneNo = '';
  var _enteredAge = 0;
  var _enteredAddress = '';
  var _enteredBlood = '';
  final myControllerName = TextEditingController();
  final myControllerPhoneNo = TextEditingController();
  final myControllerAge = TextEditingController();
  final myControllerAddress = TextEditingController();
  final myControllerBlood = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    DBref.child(userId).child("userData").child(_enteredName).set({
      'name': _enteredName,
      'phoneNo': _enteredPhoneNo,
      'age': _enteredAge,
      'address': _enteredAddress,
      'bloodGroup': _enteredBlood,
      'temperature':intialValue,
      'pulseRate':intialValue,
      'Smart Watch':false,
      'Medication Box':false
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Id'),
        backgroundColor: Colors.green,
      ),
      body: Card(
        margin: EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://miro.medium.com/max/570/1*sDVFp8mWc5aTfKIQeR_Dzg.jpeg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextField(
                        controller: myControllerName,
                        decoration: InputDecoration(
                          labelText: "Patient's name",
                          labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                        ),
                        // onChanged:
                        onChanged: (value) {
                          setState(() {
                            _enteredName = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: myControllerPhoneNo,
                        decoration: InputDecoration(
                          labelText: 'Phone no',
                          labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                        ),
                        // onChanged:
                        onChanged: (value) {
                          setState(() {
                            _enteredPhoneNo = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: myControllerAge,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                        ),
                        // onChanged:
                        onChanged: (value) {
                          setState(() {
                            _enteredAge = int.parse(value);
                          });
                        }),
                  ),
                  Expanded(
                    child: TextField(
                        controller: myControllerAddress,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                        ),
                        // onChanged:
                        onChanged: (value) {
                          setState(() {
                            _enteredAddress = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: TextField(
                        controller: myControllerBlood,
                        decoration: InputDecoration(
                          labelText: 'Blood group',
                          labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                        ),
                        // onChanged:
                        onChanged: (value) {
                          setState(() {
                            _enteredBlood = value;
                          });
                        }),
                  ),
                  RaisedButton(
                    onPressed: _sendMessage,
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    color: Colors.green,
                  ),
                ],
              )),
        ),
      ),
    );
  }
  Future<String> getId() async {
    final user = await FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}