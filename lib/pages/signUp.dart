
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:med_tracker/pages/signIn.dart';
import 'package:med_tracker/service/auth_service.dart';

import 'homePage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          color: Colors.black,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Sign Up",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 35,
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
                const Text(
                  "If you already have an Account? ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => const SignIn()),
                            (route) => false);
                  },
                  child: const Text(
                    "Login ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget buttonItem(String imagepath, String buttonname, double size) {
    return InkWell(
      onTap: ()async{
        // await authClass.googleSignIn(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
            color: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(
                  width: 1,
                  color: Colors.white,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagepath,
                  height: size,
                  width: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(buttonname,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    )),
              ],
            )),
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
        style: TextStyle(fontSize: 17, color: Colors.white),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(fontSize: 17, color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.white,
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
          await firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);

            print("in");
             await authClass.storeTokenAndData(userCredential);  // added to store the credentials while signing up

          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
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
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}
