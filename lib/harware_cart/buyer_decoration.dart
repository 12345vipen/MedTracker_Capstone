import 'package:flutter/material.dart';
import 'hardware_screen.dart';

class BuyerDecoration extends StatefulWidget {
  final String name;
  final String phoneNo;
  final String bloodGroup;
  final int age;

  const BuyerDecoration(
      {Key? key,
        required this.name,
        required this.age,
        required this.bloodGroup,
        required this.phoneNo})
      : super(key: key);

  @override
  _BuyerDecorationState createState() => _BuyerDecorationState();
}

class _BuyerDecorationState extends State<BuyerDecoration> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HardwareScreen(name:widget.name,phoneNo:widget.phoneNo),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMeua1mfDPv9_khPuYx2CzXw-XFFUogCEe1w&usqp=CAU"),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
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
              child: ListTile(
                leading: Icon(
                  Icons.medical_services_outlined,
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
          ],
        ),
      ),
    );
  }
}
