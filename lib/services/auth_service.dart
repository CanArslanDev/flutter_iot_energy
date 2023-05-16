import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in function
  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    var collectionuser = FirebaseFirestore.instance.collection('users');
    var docSnapshotuser = await collectionuser.doc(user.user!.uid).get();
    if (docSnapshotuser.exists) {
      Map<String, dynamic>? datauser = docSnapshotuser.data();
      await ValueService().initializeLogin(
          datauser?['username'], email, datauser?['phone'], user.user?.uid);
    }
    return user.user!;
  }

  //sign out function
  signOut() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'email');
    await storage.delete(key: 'password');
    await storage.delete(key: 'auth');
    return await _auth.signOut();
  }

  //sign up function
  Future<User> signUp(
      String name, String email, String phone, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("users").doc(user.user!.uid).set({
      'username': name,
      'email': email,
      'phone': phone,
      'totalActiveScene': 0,
      'totalDeviceCount': 0,
    });
    return user.user!;
  }

  Future<User> signInGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (await FirebaseService().authGetUser(userCredential.user!.uid) ==
        false) {
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'username': userCredential.user?.displayName,
        'email': userCredential.user?.email,
        'phone': userCredential.user?.phoneNumber,
        'totalDeviceCount': 0,
        'totalActiveScene': 0,
      });
    }
    await ValueService().initializeLogin(
        userCredential.user?.displayName,
        userCredential.user?.email,
        userCredential.user?.phoneNumber,
        userCredential.user?.uid);
    return userCredential.user!;
  }

  Future resetPasswordEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
