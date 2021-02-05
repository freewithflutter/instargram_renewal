import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String profileImage;
  String name;
  String email;
  String uid;

  UserModel({this.profileImage, this.name, this.email});

  UserModel.fromMap(Map<String, dynamic> data) {
    profileImage = data['profileImage'];
    name = data['name'];
    email = data['email'];
    uid = data['uid'];
  }
}
