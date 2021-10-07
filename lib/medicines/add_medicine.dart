import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AddMedicine extends StatefulWidget {
  String patientId;
  String userId;
   AddMedicine({Key? key,required this.userId, required this.patientId}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  @override
  // Realtime Database
  final DBref = FirebaseDatabase.instance.reference();

  var _enteredName = '';
  final myControllerName = TextEditingController();
  // time at which u take your medicine
  bool morning = false;
  bool afternoon = false;
  bool night = false;
  // time picker
  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;
  String _timePicked = "";
  Future selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
      // _timePicked = _time as String;
      print(_time);
      _timePicked = formatTimeOfDay(_time);
      print(_timePicked);
    });
  }
  // converting TimeofDay into String

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    DBref.child(widget.userId).child("Medicines").child(widget.patientId).child(_enteredName).set({
      'name': _enteredName,
      'patientId':widget.patientId,
      'time':_timePicked,
      'userId':widget.userId,
      'moring': morning,
      'afternoon': afternoon,
      'night': night,
      'quantity': 0,
      'price':100
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicines Details',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(20),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  TextField(
                        controller: myControllerName,
                        decoration: const InputDecoration(
                          labelText: "Medicine name",
                          labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                          ),
                        ),
                        // onChanged:
                        onChanged: (value) {
                          setState(() {
                            _enteredName = value;
                          });
                        }),

                  SizedBox(height: MediaQuery.of(context).size.height*.15,),
                  RaisedButton(
                    color: Colors.lightGreen,
                    onPressed: () async {
                      selectTime(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Select the time to take medicine',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.alarm),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.1,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'When do you take your medicine?',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'In morning     ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Checkbox(
                                value: morning,
                                onChanged: (value) {
                                  setState(() {
                                    morning = value!;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'At afternoon',
                              style: TextStyle(fontSize: 15),
                            ),
                            Checkbox(
                                value: afternoon,
                                onChanged: ( value) {
                                  setState(() {
                                    afternoon = value!;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'At night         ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Checkbox(
                                value: night,
                                onChanged: ( value) {
                                  setState(() {
                                    night = value!;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.1,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.03,
                  ),
                ],
              )),

        ),
      ),
    );
  }
}

