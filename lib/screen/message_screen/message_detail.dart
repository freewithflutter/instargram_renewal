import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageDetail extends StatefulWidget {
  static String id = 'messageDetail';

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  String message;
  TextEditingController messages = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('message'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (value) => setState(() {
                  message = value;
                }),
                controller: messages,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // Map<String, dynamic> data = {
                      //   'message': messages.text,
                      // };
                      String dam = message;

                      message.isEmpty
                          ? null
                          : FirebaseFirestore.instance
                              .collection('chats')
                              .doc(_user.uid)
                              .collection('message')
                              .doc('DmWEPlC3DHMWRte1eAiA')
                              .update({
                              'message': FieldValue.arrayUnion([dam]),
                            });
                      messages.clear();
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
            Container(
              height: 400,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(_user.uid)
                      .collection('message')
                      .doc('DmWEPlC3DHMWRte1eAiA')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Text(snapshot.data
                              .data()['message'][index]
                              .toString()),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
