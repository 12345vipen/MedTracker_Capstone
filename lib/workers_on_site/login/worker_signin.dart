
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:med_tracker/pages/signUp.dart';
import 'package:med_tracker/service/auth_service.dart';
import 'package:med_tracker/workers_on_site/login/worker_signup.dart';

import '../homePageWorker.dart';



class WorkerSignIn extends StatefulWidget {
  const WorkerSignIn({Key? key}) : super(key: key);

  @override
  _WorkerSignInState createState() => _WorkerSignInState();
}

class _WorkerSignInState extends State<WorkerSignIn> {

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffc5cae9),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Sign In",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 70,
            ),

            textItem("Email...", _emailController, false),
            const SizedBox(
              height: 15,
            ),
            textItem("Password...", _passwordController, true),
            const SizedBox(
              height: 30,
            ),
            colorButton(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("If you don't have an Account? ",style: TextStyle(color: Colors.black,fontSize: 18),),
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => const WorkerSignUp()),
                              (route) => false);
                    },
                    child: const Text("Sign Up ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Forgot Password",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
          ]),
        ),
      ),
    );
  }

  // for emails and password section

  Widget textItem(
      String labeltext, TextEditingController controller, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 70,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(fontSize: 17, color: Colors.black),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(fontSize: 17, color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);
          await authClass.storeTokenAndData(userCredential);  // added to store the credentials while WorkerSignIng up
          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePageWorker()),
                  (route) => false);
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: Center(
            child: circular
                ? CircularProgressIndicator()
                : Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}
