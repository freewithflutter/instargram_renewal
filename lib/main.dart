import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instargram_renewal/provider/google_sign_in_provider.dart';
import 'package:instargram_renewal/screen/homescreen.dart';
import 'package:instargram_renewal/screen/loginScreen/login_main.dart';
import 'package:instargram_renewal/screen/message_screen/message_detail.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'screen/app.dart';
import 'screen/message_screen/message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GoogleSignInProvider()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          routes: {
            MessageDetail.id: (context) => MessageDetail(),
            Message.id: (context) => Message(),
          },
          home: LoginMain()),
    );
  }
}
