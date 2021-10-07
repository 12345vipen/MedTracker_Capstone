import 'package:flutter/material.dart';
import 'package:med_tracker/cart/cart_screen.dart';
import 'package:med_tracker/pages/signIn.dart';
import 'package:med_tracker/pages/signUp.dart';
import 'package:med_tracker/patient_ids/home_screen.dart';
import 'package:med_tracker/payments/payment_screen.dart';
import 'package:med_tracker/service/auth_service.dart';
import 'package:med_tracker/setting_app/settings_page.dart';
import 'package:med_tracker/workers_on_site/worker_details.dart';
import 'package:med_tracker/workers_on_site/worker_setting.dart';

class HomePageWorker extends StatefulWidget {
  const HomePageWorker({ Key? key }) : super(key: key);

  @override
  HomePageWorkerState createState() => HomePageWorkerState();
}

class HomePageWorkerState extends State<HomePageWorker> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // Profile page hi settings page ha
  static const List<Widget> _widgetOptions = <Widget>[

    WorkerDetails(),
    WorkerSetting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.deepPurple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            label: 'Home',
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Colors.white,),
            label: 'Settings',
            backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.limeAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}