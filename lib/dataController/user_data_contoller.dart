import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instargram_renewal/model/user_model.dart';

class UserController extends GetxController {
  List<UserModel> _userList = [];
  String _selectedPartnerName;
  String _selectedPartnerImage;
  List<UserModel> get userList => _userList;
  String _selectedDocId;

  String get selectedPartnerImage => _selectedPartnerImage;

  set selectedPartnerImage(String value) {
    _selectedPartnerImage = value;
    update();
  }

  String get selectedPartnerName => _selectedPartnerName;

  set selectedPartnerName(String value) {
    _selectedPartnerName = value;
    update();
  }

  String get selectedDocId => _selectedDocId;

  set selectedDocId(String value) {
    _selectedDocId = value;
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

  GetSelectedPartner(UserController userController) async {
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
