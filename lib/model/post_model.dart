import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String description;
  String image;
  int likes;
  int message;
  String profileImage;
  String userName;
  String postID;
  List images;

  Post(this.description, this.image, this.likes, this.message,
      this.profileImage, this.userName, this.postID, this.images);

  Post.fromMap(Map<String, dynamic> data) {
    description = data['description'];
    image = data['image'];
    likes = data['likes'];
    message = data['message'];
    profileImage = data['profileImage'];
    userName = data['userName'];
    postID = data['postID'];
    images = data['images'];
  }
}
