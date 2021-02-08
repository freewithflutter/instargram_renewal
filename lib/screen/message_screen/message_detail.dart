import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instargram_renewal/dataController/user_data_contoller.dart';
import 'package:get/get.dart';

class MessageDetail extends StatefulWidget {
  static String id = 'messageDetail';

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  final controller = Get.put(UserController());
  String message;
  final _messages = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;
  bool _error = false;
  bool isSameUser;
  @override
  void dispose() {
    _messages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
        title: GestureDetector(
            onTap: () {
              print(controller.selectedDocId);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                    radius: 14,
                    backgroundImage:
                        NetworkImage(controller.selectedPartnerImage)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.selectedPartnerName,
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                    Text(
                      'userEmail@gmail.com',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            )),
        actions: [],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('channel')
              .doc(controller.selectedDocId)
              .collection('message')
              .orderBy('timeStamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  snapshot.data.docs[index]['uid'] == _user.uid
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.grey
                                                    .withOpacity(0.2)),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: snapshot.data.docs[index]
                                                        ['uid'] ==
                                                    _user.uid
                                                ? Colors.white
                                                : Colors.grey
                                                    .withOpacity(0.16)),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7),
                                            child: Text(
                                              snapshot.data.docs[index]
                                                  ['context'],
                                            ),
                                          ),
                                        )),
                                    snapshot.data.docs[index]['uid'] ==
                                            _user.uid
                                        ? Container()
                                        : snapshot.data.docs[index]
                                                    .data()['uid'] ==
                                                snapshot.data.docs[index + 1]
                                                    .data()['uid']
                                            ? Container()
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    controller
                                                        .selectedPartnerImage),
                                              ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (value) => setState(() {
                        message = value;
                      }),
                      controller: _messages,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        errorText: _error ? 'No value' : null,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // String currentId = FirebaseFirestore.instance
                            //     .collection('chats')
                            //     .doc()
                            //     .id;
                            Map<String, dynamic> data = {
                              'context': message,
                              'timeStamp': DateTime.now(),
                              'uid': _user.uid,
                              'photoUrl': _user.photoURL
                            };

                            FirebaseFirestore.instance
                                .collection('channel')
                                .doc(controller.selectedDocId)
                                .collection('message')
                                .add(data);

                            print(controller.selectedDocId);
                            // .update({
                            // 'message': message,
                            // 'timeStamp': DateTime.now()
                            // });as
                            _messages.clear();
                          },
                          child: Icon(Icons.send),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
