import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/dataController/google_login_controller.dart';
import 'package:instargram_renewal/dataController/user_data_contoller.dart';
import 'package:instargram_renewal/screen/message_screen/message_detail.dart';

class Message extends StatefulWidget {
  static String id = 'message';

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
  }

  final controller = Get.put(UserController());
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
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //TODO message list part Section2
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(MessageDetail());
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                    controller.userList[index].profileImage),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              controller.userList[index].name,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
