import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:med_tracker/medicines/medicine_screen.dart';

class IdDecoration extends StatefulWidget {
  final String name;
  final String phoneNo;
  final String bloodGroup;
  final int age;
  final String userId;
  final int temperature;
  final int pulseRate;

  const IdDecoration(
      {Key? key,
      required this.name,
      required this.age,
      required this.bloodGroup,
      required this.phoneNo,
      required this.userId,
      required this.pulseRate,
      required this.temperature})
      : super(key: key);

  @override
  _IdDecorationState createState() => _IdDecorationState();
}

class _IdDecorationState extends State<IdDecoration> {
  final DBref = FirebaseDatabase.instance.reference();

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        // Delete the Medications detail also
        DBref.child(widget.userId)
            .child("userData")
            .child(widget.name)
            .remove();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want to delete ${widget.name}'s Id?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MedicineScreen(name: widget.name, phoneNo: widget.phoneNo),
            ));
      },
      onLongPress: () async {
        await showAlertDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/black.jpg"),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8,
            ),
            Card(
              color: Colors.black45,
              child: ListTile(
                leading: Icon(
                  Icons.perm_contact_cal_sharp,
                  color: Colors.white,
                  size: 40,
                ),
                title: Text(
                  widget.name,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "Blood group: ${widget.bloodGroup}",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      "Age: ${widget.age.toString()} years",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * .44,
                        height: MediaQuery.of(context).size.width * .3,
                        child: Image(
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTbkTq2UEYLvxr30maLOxvyIEvpjpfrZBsGA&usqp=CAU"),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.black,
                      child: Row(
                        children: [
                          Text(
                            " Temperature: ",
                            style: TextStyle(color: Colors.white,fontSize:MediaQuery.of(context).size.width * .045 ),
                          ),
                          Text("${widget.temperature}°C",
                            style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width * .05 ),)
                        ],
                      ),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * .44,
                        height: MediaQuery.of(context).size.width * .3,
                        child: Image(
                          image: NetworkImage(
                              "https://images.ctfassets.net/y00rp5rsab3h/61dH1XVjxEzbmBIIRa8648/a19e31bf601d299142161f58738e1e71/pulse-rate.jpg"),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.black,
                      child: Row(
                        children: [
                          Text(
                            " PulseRate:  ",
                            style: TextStyle(color: Colors.white,fontSize:MediaQuery.of(context).size.width * .045 ),
                          ),
                          Text(widget.pulseRate.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width * .05 ),)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),

          ],
        ),
      ),
    );
  }
}

// sllee
/*
SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      progressBarColor: Colors.transparent,
                      trackColor: Colors.green,
                      dotColor: Colors.red,
                    ),
                    customWidths: CustomSliderWidths(
                      trackWidth: 5,
                      shadowWidth: 0,
                      progressBarWidth: 01,
                      handlerSize: 7,
                    ),
                  ),
                  initialValue: temp,
                  onChange: (double value) {

                      temp = value;

                  },
                  innerWidget: (percentage) {
                    return Center(
                      child: Text(
                        'Teperature ${widget.temperature}°c',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                      hideShadow: false,
                      progressBarColor: Colors.blue,
                      trackColor: Colors.blue,
                      dotColor: Colors.orangeAccent,
                    ),
                    customWidths: CustomSliderWidths(
                      trackWidth: 5,
                      shadowWidth: 0,
                      progressBarWidth: 01,
                      handlerSize: 7,
                    ),
                  ),
                  initialValue: pulseRate,
                  onChange: (double value) {

                      pulseRate = value;

                  },
                  innerWidget: (percentage) {
                    return Center(
                      child: Text(
                        'Pulse Rate ${widget.pulseRate}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ),
 */
