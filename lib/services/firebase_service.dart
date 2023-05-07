import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> authGetUser(String accountId) async {
    try {
      bool condition = false;
      var collectionuser = _firestore.collection('users');
      var docSnapshotuser = await collectionuser.doc(accountId).get();
      if (docSnapshotuser.exists) {
        condition = true;
      }
      return condition;
    } catch (e) {
      return false;
    }
  }
}
