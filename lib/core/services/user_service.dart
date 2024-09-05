import 'package:chatgram/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _userFirebase = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user, String uid) async {
    print("Keldi add qilishga");
    try {
      await _userFirebase.doc(uid).set(user.toMap());
    } catch (e) {
      print(e);
    }
  }


  Stream<QuerySnapshot> getAllUsers() async*{
yield*
    _userFirebase.snapshots();

  }
}
