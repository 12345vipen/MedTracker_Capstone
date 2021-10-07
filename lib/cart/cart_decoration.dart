import 'package:flutter/material.dart';

import 'cart_medicines.dart';

class CartDecoration extends StatefulWidget {
  final String name;
  final String phoneNo;
  final String bloodGroup;
  final int age;

  const CartDecoration(
      {Key? key,
        required this.name,
        required this.age,
        required this.bloodGroup,
        required this.phoneNo})
      : super(key: key);

  @override
  _CartDecorationState createState() => _CartDecorationState();
}

class _CartDecorationState extends State<CartDecoration> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartMedicines(name:widget.name,phoneNo:widget.phoneNo,orderPlaced: false,),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://t3.ftcdn.net/jpg/03/10/36/74/360_F_310367417_qCiRPpRkadGgStzWJVsrIJWyUPQ70uPg.jpg"),
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
