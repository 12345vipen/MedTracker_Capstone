import 'package:flutter/material.dart';
import 'package:med_tracker/cart/cart_screen.dart';
import 'package:med_tracker/harware_cart/choose_buyer.dart';
import 'package:med_tracker/harware_cart/hardware_screen.dart';
import 'package:med_tracker/patient_ids/alarm.dart';
import 'package:med_tracker/patient_ids/home_screen.dart';
import 'package:med_tracker/realtime_medTracker/crud.dart';
import 'package:med_tracker/service/auth_service.dart';
import 'package:med_tracker/setting_app/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // Profile page hi settings page ha
  static  List<Widget> _widgetOptions = <Widget>[

    HomeScreen(),
    ChooseBuyer(),
    Alarm(),  // cartScreen
    ProfilePage(),
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

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_rounded),
            label: 'Hardware',
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
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