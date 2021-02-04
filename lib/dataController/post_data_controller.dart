import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/model/post_model.dart';

class PostController extends GetxController {
  final _user = FirebaseAuth.instance;
  var list;

  Future getPostData(String collection) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return snapshot;
  }

  String selectedDs;
  String selectedId;
  List<Post> _postList = [];

  List<Post> get postList => _postList;

  set postList(List<Post> value) {
    _postList = value;
    update();
  }

  getPost(PostController postController) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    List<Post> _postLista = [];

    snapshot.docs.forEach((document) {
      Post post = Post.fromMap(document.data());
      _postLista.add(post);
    });

    postController._postList = _postLista;
  }
}
