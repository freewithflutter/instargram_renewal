import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/model/user_model.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  Rx<UserModel> get userModel => _userModel;

  set userModel(Rx<UserModel> value) {
    _userModel = value;
  }

  void clear() {
    _userModel.value = userModel();
  }

  final _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .set({'name': user.name, 'email': user.email});
    } catch (e) {
      print(e);
      return false;
    }

    Future<UserModel> getUser(String uid) async {
      try {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(uid).get();
        return UserModel.fromDocumentSnapshot(doc);
      } catch (e) {
        print(e);
      }
    }
  }
}
