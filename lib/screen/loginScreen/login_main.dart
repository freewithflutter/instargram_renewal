import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/dataController/google_login_controller.dart';
import 'package:instargram_renewal/provider/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

import '../app.dart';

class LoginMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (provider.isSigningIn) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return App();
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        child: GetBuilder<GoogleSigninController>(
                      init: GoogleSigninController(),
                      builder: (value) {
                        return GestureDetector(
                            onTap: () {
                              value.login();
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text('구글 로그인')));
                      },
                    )),
                    Card(
                        child: GestureDetector(
                            onTap: () {
                              provider.logout();
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text('로그아웃')))),
                  ],
                ),
              ),
            );
          }
        });
  }
}

// {
// if (provider.isSigningIn) {
// return CircularProgressIndicator();
// } else if (snapshot.hasError) {
// return Text('Error!');
// } else if (snapshot.hasData) {
// App();
// } else {
// return Scaffold(
// body: Center(
// child: Card(
// child: GestureDetector(
// onTap: () {
// provider.login();
// },
// child: Container(
// padding: EdgeInsets.all(20),
// child: Text('구글 로그인')))),
// ),
// );
// }
// }
