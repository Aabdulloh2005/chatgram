
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String name;
  String email;
  String? fcmToken;
  String? photo;
  String? description;
  UserModel({
    this.uid,
    required this.name,
    required this.email,
    this.fcmToken,
    this.photo,
    this.description,
  });
 

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'fcmToken': fcmToken,
      'photo': photo,
      'description': description,
    };
  }

  factory UserModel.fromMap(QueryDocumentSnapshot map) {
    return UserModel(
      uid: map.id,
      name: map['name'] as String,
      email: map['email'] as String,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
