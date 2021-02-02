import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/dataController/post_data_controller.dart';
import 'package:instargram_renewal/provider/google_sign_in_provider.dart';

class HomeScreen extends StatelessWidget {
  final _user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //TODO Section 1 (About users story part)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 58,
                child: Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.network(
                            _user.currentUser.photoURL,
                            fit: BoxFit.contain,
                            width: 30,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '내 스토리',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //TODO Section2 (about user's post)
              GetBuilder<PostController>(
                init: PostController(),
                builder: (value) {
                  return FutureBuilder(
                      future: value.getPostData('posts'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Align(
                                alignment: Alignment.topLeft,
                                heightFactor: 0.88,
                                child: Stack(
                                  //TODO Post image
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 14),
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(42),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                        child: Image.network(
                                          snapshot.data.docs[index]
                                              .data()['image'],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                        ),
                                      ),
                                    ),
                                    //TODO User's profile
                                    Positioned(
                                        child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      margin: EdgeInsets.only(
                                          top: 14, left: 15, right: 15),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black87
                                                  .withOpacity(0.075),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color:
                                              Colors.black87.withOpacity(0.00),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(42),
                                              topRight: Radius.circular(42))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: CircleAvatar(
                                                  backgroundImage: ExactAssetImage(
                                                      'assets/images/avatar_post.jpg'),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  snapshot.data.docs[index]
                                                      .data()['userName'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )),
                                    //TODO Likes & other Icons
                                    Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.54,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade500
                                                      .withOpacity(0.3),
                                                  spreadRadius: 4,
                                                  blurRadius: 4,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.48,
                                            height: 52,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12),
                                                        child: Image.asset(
                                                          'assets/icons/Heart.png',
                                                          height: 26,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${snapshot.data.docs[index].data()['likes']}',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        'assets/icons/Comment.png'),
                                                    Text(
                                                      '${snapshot.data.docs[index].data()['message']}',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Image.asset(
                                                        'assets/icons/Bookmark.png')),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
