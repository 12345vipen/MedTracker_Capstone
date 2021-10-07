import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_tracker/pages/signUp.dart';
import 'package:med_tracker/service/auth_service.dart';

import 'login/worker_signup.dart';

class WorkerSetting extends StatefulWidget {
  const WorkerSetting({Key? key}) : super(key: key);

  @override
  State<WorkerSetting> createState() => _WorkerSettingState();
}

class _WorkerSettingState extends State<WorkerSetting> {
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc5cae9),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
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
                height: 200,
                width: 200,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQy_PSNOOjD2w1tUHD9W4gxuGnHCNFHTLpnvg&usqp=CAU"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              color: Color(0xffc5cae9),
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
                  const ListTile(
                    leading: Icon(
                      Icons.payment,
                      size: 40,
                      color: Colors.lightGreen,
                    ),
                    title: Text('Salary'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await authClass.logout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => WorkerSignUp()),
                              (route) => false);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 40,
                        color: Colors.redAccent,
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
