import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:instargram_renewal/dataController/google_login_controller.dart';

class Message extends StatefulWidget {
  static String id = 'message';

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final _user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            Get.put(GoogleSigninController().logout());
          },
          child: Text(
            _user.currentUser.displayName,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            //TODO SearchPart Section 1
            Container(
              color: Colors.grey,
              height: 50,
              width: double.infinity,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
