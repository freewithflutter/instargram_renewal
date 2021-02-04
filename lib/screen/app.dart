import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instargram_renewal/provider/google_sign_in_provider.dart';
import 'package:instargram_renewal/screen/message.dart';
import 'package:instargram_renewal/screen/mylikes_screen/mylikes_main.dart';
import 'package:instargram_renewal/screen/mypage_screen/mypage_main.dart';
import 'package:instargram_renewal/screen/searchPost_screen/searchPost_main.dart';
import 'package:instargram_renewal/screen/uploadPost_screen/uploadPost_main.dart';
import 'package:instargram_renewal/utill/component.dart';
import 'package:provider/provider.dart';

import 'homescreen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await FirebaseFirestore.instance.collection('users').doc(_user.uid).set({
        'name': _user.displayName,
        'email': _user.email,
        'profileImage': _user.photoURL,
        'likes': [],
      });
    });

    super.initState();
  }

  int _selectedIndex = 0;
  PageController _controller = PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      appBar: _selectedIndex == 3
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            )
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              title: Image.asset(
                'assets/images/Instagram_logo.png',
                fit: BoxFit.fill,
                width: 120,
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              ),
              actions: [
                Image.asset(
                  'assets/icons/Heart.png',
                  fit: BoxFit.contain,
                  height: 28,
                  width: 28,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Message.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, left: 25),
                    child: Image.asset(
                      'assets/icons/Mail.png',
                      fit: BoxFit.contain,
                      height: 28,
                      width: 28,
                    ),
                  ),
                ),
              ],
            ),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            HomeScreen(),
            SearchPost(),
            UploadPost(),
            Message(),
            MyPage(),
          ]),
      extendBody: true,
      bottomNavigationBar: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.009),
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: BlurryContainer(
          bgColor: Colors.white,
          height: 70,
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  _controller.animateToPage(_selectedIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/home_border.png',
                      height: 28,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/home.png',
                      height: 28,
                    ),
                    label: 'hi'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/Search.png'), label: 'hi'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/Add.png', height: 28),
                    label: 'hi'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/Bookmark.png'),
                    label: 'hi'),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                        radius: 14.0,
                        backgroundImage: NetworkImage(_user.photoURL)),
                    label: 'hi'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
