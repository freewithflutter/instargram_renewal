import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String description;
  String image;
  int likes;
  int message;
  String profileImage;
  String userName;

  Post(this.description, this.image, this.likes, this.message,
      this.profileImage, this.userName);

  Post.fromDocumentSnapshot(DocumentSnapshot ds) {
    description = ds['description'];
    image = ds['image'];
    likes = ds['likes'];
    message = ds['message'];
    profileImage = ds['profileImage'];
    userName = ds['userName'];
  }
}
