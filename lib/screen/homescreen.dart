import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/dataController/post_data_controller.dart';
import 'package:instargram_renewal/provider/google_sign_in_provider.dart';
import 'package:favorite_button/favorite_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _shoWDescription = false;
  final _firesote = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance;
  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   await _firesote.collection('users').doc(_user.currentUser.uid).set({
    //     "likes": [],
    //   });
    // });
    // Load data form firestore to getX
    final controller = Get.put(PostController());
    controller.getPost(controller);
    super.initState();
  }

  final controller = Get.put(PostController());
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
                        GestureDetector(
                          onTap: () async {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              _user.currentUser.photoURL,
                              fit: BoxFit.contain,
                              width: 30,
                            ),
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
              ListView.builder(
                primary: false,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.postList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.topLeft,
                    heightFactor: 0.88,
                    child: Stack(
                      //TODO Post image
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              _shoWDescription = true;
                              print(_shoWDescription);
                            });
                          },
                          onTap: () {
                            setState(() {
                              print(_shoWDescription);
                              _shoWDescription = false;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.7,
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
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('posts')
                                      .snapshots(),
                                  builder: (context, imageSnapshot) {
                                    return Swiper(
                                      itemBuilder:
                                          (BuildContext context, int aim) {
                                        return StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('posts')
                                                .snapshots(),
                                            builder: (context, Dessnapshot) {
                                              return GestureDetector(
                                                onLongPress: () {
                                                  controller.selectedDs =
                                                      Dessnapshot
                                                          .data.docs[index].id;
                                                  FirebaseFirestore.instance
                                                      .collection('posts')
                                                      .doc(
                                                          controller.selectedDs)
                                                      .update({
                                                    'showDescription':
                                                        FieldValue.arrayUnion([
                                                      _user.currentUser.uid
                                                    ])
                                                  });
                                                },
                                                child: Image.network(
                                                  controller.postList[index]
                                                      .images[aim],
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.7,
                                                ),
                                              );
                                            });
                                      },
                                      itemCount: imageSnapshot.data.docs[index]
                                          .data()['images']
                                          .length,
                                      viewportFraction: 1,
                                      scale: 1,
                                    );
                                  }),
                            ),
                          ),
                        ),

                        //TODO User's profile
                        Positioned(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .snapshots(),
                                builder: (context, Postsnapshot) {
                                  return GestureDetector(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(controller.selectedDs)
                                          .update({
                                        'showDescription':
                                            FieldValue.arrayRemove(
                                                [_user.currentUser.uid])
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, top: 16),
                                      height: Postsnapshot.data.docs[index]
                                              .data()['showDescription']
                                              .contains(_user.currentUser.uid)
                                          ? MediaQuery.of(context).size.height *
                                              0.7
                                          : MediaQuery.of(context).size.height *
                                              0.1,
                                      margin: EdgeInsets.only(
                                          top: 14, left: 15, right: 15),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Postsnapshot
                                                      .data.docs[index]
                                                      .data()['showDescription']
                                                      .contains(
                                                          _user.currentUser.uid)
                                                  ? Colors.black87
                                                      .withOpacity(0.4)
                                                  : Colors.black87
                                                      .withOpacity(0.075),
                                              spreadRadius: 0,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      controller.postList[index]
                                                          .profileImage),
                                                  // backgroundImage: ExactAssetImage(
                                                  //     'assets/images/avatar_post.jpg'),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  controller
                                                      .postList[index].userName,
                                                  // snapshot.data.docs[index]
                                                  //     .data()['userName'],
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
                                    ),
                                  );
                                })),
                        //TODO Likes & other Icons
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.54,
                            right: MediaQuery.of(context).size.width * 0.2,
                            left: MediaQuery.of(context).size.width * 0.2,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: Colors.white.withOpacity(0.8),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade500.withOpacity(0.3),
                                      spreadRadius: 4,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 0.48,
                                height: 52,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 12),
                                            child: StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(_user.currentUser.uid)
                                                    .snapshots(),
                                                builder:
                                                    (context, userSnapshot) {
                                                  return StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('posts')
                                                          .snapshots(),
                                                      builder: (context,
                                                          postSnapshot) {
                                                        return Row(
                                                          children: [
                                                            FavoriteButton(
                                                              valueChanged:
                                                                  (_) async {
                                                                controller
                                                                        .selectedId =
                                                                    postSnapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .id;
                                                                if (userSnapshot
                                                                    .data
                                                                    .data()[
                                                                        'likes']
                                                                    .contains(
                                                                        controller
                                                                            .selectedId)) {
                                                                  await _firesote
                                                                      .collection(
                                                                          'users')
                                                                      .doc(_user
                                                                          .currentUser
                                                                          .uid)
                                                                      .update({
                                                                    'likes':
                                                                        FieldValue
                                                                            .arrayRemove([
                                                                      controller
                                                                          .selectedId
                                                                    ])
                                                                  });

                                                                  await _firesote
                                                                      .collection(
                                                                          'posts')
                                                                      .doc(controller
                                                                          .selectedId)
                                                                      .update({
                                                                    'liked':
                                                                        FieldValue
                                                                            .arrayRemove([
                                                                      _user
                                                                          .currentUser
                                                                          .uid
                                                                    ])
                                                                  });

                                                                  await _firesote
                                                                      .collection(
                                                                          'posts')
                                                                      .doc(controller
                                                                          .selectedId)
                                                                      .update({
                                                                    'likes': FieldValue
                                                                        .increment(
                                                                            -1)
                                                                  });
                                                                } else {
                                                                  await _firesote
                                                                      .collection(
                                                                          'users')
                                                                      .doc(_user
                                                                          .currentUser
                                                                          .uid)
                                                                      .update({
                                                                    'likes':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      controller
                                                                          .selectedId
                                                                    ])
                                                                  });

                                                                  await _firesote
                                                                      .collection(
                                                                          'posts')
                                                                      .doc(controller
                                                                          .selectedId)
                                                                      .update({
                                                                    'liked':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      _user
                                                                          .currentUser
                                                                          .uid
                                                                    ])
                                                                  });

                                                                  await _firesote
                                                                      .collection(
                                                                          'posts')
                                                                      .doc(controller
                                                                          .selectedId)
                                                                      .update({
                                                                    'likes': FieldValue
                                                                        .increment(
                                                                            1)
                                                                  });
                                                                }
                                                              },
                                                              isFavorite: postSnapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .data()[
                                                                      'liked']
                                                                  .contains(_user
                                                                      .currentUser
                                                                      .uid),
                                                              iconSize: 40,
                                                              iconColor:
                                                                  Colors.amber,
                                                            ),
                                                            SizedBox(
                                                                width: postSnapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .data()[
                                                                            'liked']
                                                                        .contains(_user
                                                                            .currentUser
                                                                            .uid)
                                                                    ? 3
                                                                    : 2),
                                                            Text(
                                                              '${postSnapshot.data.docs[index].data()['likes']}',
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset('assets/icons/Comment.png'),
                                        Text(
                                          '${controller.postList[index].message}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Image.asset(
                                            'assets/icons/Bookmark.png')),
                                  ],
                                ),
                              ),
                            )),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.34,
                            right: MediaQuery.of(context).size.width * 0.2,
                            left: MediaQuery.of(context).size.width * 0.2,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.15),
                              color: Colors.transparent,
                              child: Center(
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('posts')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data.docs[index]
                                                .data()['showDescription']
                                                .contains(_user.currentUser.uid)
                                            ? controller
                                                .postList[index].description
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                              ),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
