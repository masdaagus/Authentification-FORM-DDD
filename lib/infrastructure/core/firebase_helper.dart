import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/models/user_model.dart';

extension FirebaseHelper on FirebaseFirestore {
  /// [ CREATE USER ]
  Future<void> createUser(UserModel user) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(user.toJson());
  }

  /// [ GET USER ]
  Future<UserModel?> readUser(String uid) async {
    var user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    Map<String, dynamic>? _userMap = user.data();

    if (_userMap != null) {
      return UserModel.fromJson(_userMap);
    }
  }

  /// [ UPDATE USER ]
  Future<void> updateUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update(user.toJson());
  }
}
