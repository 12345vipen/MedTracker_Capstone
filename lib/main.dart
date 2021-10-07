// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:med_tracker/service/auth_service.dart';
// import 'package:med_tracker/workers_on_site/homePageWorker.dart';
// import 'package:med_tracker/workers_on_site/login/worker_signup.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   AuthClass authClass = AuthClass();
//   Widget currentPage = WorkerSignUp();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkLogin();
//   }
//   void checkLogin() async{
//     if(await authClass.getToken()!=null) {
//       print("tokne");
//       setState(() {
//         currentPage = HomePageWorker();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home:  currentPage,
//     );
//   }
// }

// Capstone

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_tracker/pages/homePage.dart';
import 'package:med_tracker/pages/signUp.dart';
import 'package:med_tracker/service/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  await AndroidAlarmManager.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUp();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  void checkLogin() async{
    if(await authClass.getToken()!=null) {
      print("tokne");
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home:  currentPage,
    );
  }
}

