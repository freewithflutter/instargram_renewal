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
  bool _switch = true;

  @override
  void dispose() {
    _messages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              print(controller.selectedDocId);
            },
            child: Text('message')),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                color: Colors.redAccent,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(controller.selectedUid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data['message'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: snapshot.data['message'][index]
                                          ['uid'] ==
                                      _user.uid
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data['message'][index]['context'],
                                    textAlign: TextAlign.end),
                              ],
                            ),
                          );
                        },
                      );
                    }),
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
                      Map<String, dynamic> data = {
                        'context': message,
                        'timeStamp': DateTime.now(),
                        'uid': _user.uid,
                      };

                      message.isEmpty
                          ? null
                          : FirebaseFirestore.instance
                              .collection('chats')
                              .doc(controller.selectedUid)
                              .update({
                              'message': FieldValue.arrayUnion([data])
                            });
                      String aim =
                          FirebaseFirestore.instance.collection('chats').id;
                      print(aim);

                      // .update({
                      // 'message': message,
                      // 'timeStamp': DateTime.now()
                      // });
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
      ),
    );
  }
}
