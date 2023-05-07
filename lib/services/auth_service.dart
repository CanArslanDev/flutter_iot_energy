import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in function
  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user!;
  }

  //sign out function
  signOut() async {
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
      });
    }
    return userCredential.user!;
  }

  void resetPasswordEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
