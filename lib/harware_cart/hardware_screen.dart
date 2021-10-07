import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:med_tracker/harware_cart/hardware_order.dart';

class HardwareScreen extends StatefulWidget {
  final String name;
  final String phoneNo;
  const HardwareScreen({Key? key,
  required this.name,required this.phoneNo}) : super(key: key);

  @override
  _HardwareScreenState createState() => _HardwareScreenState();
}

class _HardwareScreenState extends State<HardwareScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HardwareOrder(productName:"Medication Box",price:1500,name:widget.name,phoneNo:widget.phoneNo),
                    ));
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width-20,
                  height: MediaQuery.of(context).size.height*.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://thumbs.dreamstime.com/b/weekly-pill-box-morning-evening-compartments-one-week-time-blue-pink-113939895.jpg"),
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
                        child:ListTile(

                          title: Text(
                            "Medication Box",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          subtitle: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Price: 1500Rs",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HardwareOrder(productName:"Smart Watch",price:2000,name:widget.name,phoneNo: widget.phoneNo,),
                    ));
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width-20,
                  height: MediaQuery.of(context).size.height*.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://i.ytimg.com/vi/ZBr22-vJ2pc/maxresdefault.jpg"),
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
                        child: ListTile(

                          title: Text(
                            "Smart Watch",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          subtitle: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Price: 2000Rs",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
