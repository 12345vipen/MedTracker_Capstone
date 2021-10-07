import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicineDecoration extends StatefulWidget {
  String name;
  String time;
  String patientId;
  int quantity;
  int index;
  String userId;
  MedicineDecoration(
      {Key? key,
      required this.name,
      required this.patientId,
      required this.quantity,
      required this.time,
      required this.index,
      required this.userId,
  })
      : super(key: key);

  @override
  _MedicineDecorationState createState() => _MedicineDecorationState();
}

class _MedicineDecorationState extends State<MedicineDecoration> {
  List listImagesnotFound = [
    "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/323514_2200-732x549.jpg",
    "https://medlineplus.gov/images/Medicines.jpg",
    "https://archive2021.parliament.scot/S5_HealthandSportCommittee/Inquiries/Pills_web.jpg",
    "https://www.who.int/images/default-source/wpro/countries/papua-new-guinea/news/20190815-registration-system-for-safe-meds.jpg?sfvrsn=d6012d58_2",
  ];

  final DBref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red[900],
      highlightColor: Colors.deepPurpleAccent,
      // splashFactory: ,
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed('/MedDetailScreen', arguments: _dataPass);
      },
      child: Card(
        child: ListTile(
          leading: Image.network(listImagesnotFound[
                  widget.index < listImagesnotFound.length
                      ? widget.index
                      : widget.index % listImagesnotFound.length]
              .toString(),width: MediaQuery.of(context).size.width*.25,),
          title: Text(
              (widget.name=="")?"Medicine name":
            widget.name.toString(),
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time: ${widget.time}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Quantity: ${widget.quantity}',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // delete data
              DBref.child(widget.userId).child("Medicines").child(widget.patientId).child(widget.name).remove();
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}

//
// DBref.child(widget.userId).child(widget.patientId).child(widget.name).once().then((DataSnapshot snapshot){
// return snapshot.value['quantity'];
// })
