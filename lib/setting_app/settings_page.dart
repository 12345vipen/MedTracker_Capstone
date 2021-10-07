import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_tracker/harware_cart/choose_buyer.dart';
import 'package:med_tracker/pages/signUp.dart';
import 'package:med_tracker/service/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("Settings")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/appProfile.jpg"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.grey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.account_box,
                      size: 40,
                      color: Colors.blue,
                    ),
                    title: Text('My Account'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseBuyer(),
                          ));
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.medical_services_outlined,
                        size: 40,
                        color: Colors.lightGreen,
                      ),
                      title: Text('Order -> Medication Tracker Kit'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.video_collection,
                      size: 40,
                      color: Colors.red,
                    ),
                    title: Text('Demo Video'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await authClass.logout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => SignUp()),
                          (route) => false);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
