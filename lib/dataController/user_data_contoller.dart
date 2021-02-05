import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/model/user_model.dart';

class UserController extends GetxController {
  List<UserModel> _userList = [];
  String _selectedUid;
  List<UserModel> get userList => _userList;

  String get selectedUid => _selectedUid;

  set selectedUid(String value) {
    _selectedUid = value;
  }

  set userList(List<UserModel> value) {
    _userList = value;
    update();
  }

  GetUser(UserController userController) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    List<UserModel> _userLista = [];

    snapshot.docs.forEach((document) {
      UserModel userModel = UserModel.fromMap(document.data());
      _userLista.add(userModel);
    });

    userController._userList = _userLista;
  }
}
