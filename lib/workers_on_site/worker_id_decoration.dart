import 'package:flutter/material.dart';
import 'package:med_tracker/medicines/medicine_screen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class WorkerIdDecoration extends StatefulWidget {
  final String name;
  final String phoneNo;
  final String bloodGroup;
  final int age;

  const WorkerIdDecoration(
      {Key? key,
        required this.name,
        required this.age,
        required this.bloodGroup,
        required this.phoneNo})
      : super(key: key);

  @override
  _WorkerIdDecorationState createState() => _WorkerIdDecorationState();
}

class _WorkerIdDecorationState extends State<WorkerIdDecoration> {
  double temp = 25;
  double pulseRate = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://media.istockphoto.com/photos/purple-abstract-background-picture-id1265139669?b=1&k=20&m=1265139669&s=170667a&w=0&h=e8ZdL5cBRj1Tk6fiYcAHJin78_bbFGuUX3f9t_eYdjQ="),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 8,
          ),
          Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.perm_contact_cal_sharp,
                color: Colors.black,
                size: 40,
              ),
              title: Text(
                widget.name,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              trailing: Text(
                "Id: ${widget.age.toString()}",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              subtitle: Text(
                "Address: ${widget.bloodGroup}",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
