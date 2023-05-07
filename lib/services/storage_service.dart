import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_service.dart';

class StorageService {
  final storage = const FlutterSecureStorage();
  void setEmailPasswordAuth(String email, String password) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
    await storage.write(key: 'auth', value: 'email');
  }

  void setGoogleAuth() async {
    await storage.write(key: 'auth', value: 'google');
  }

  getAutomaticSignAuth(VoidCallback callback) async {
    String? auth = await storage.read(key: 'auth');
    if (auth == 'email') {
      try {
        String? email = await storage.read(key: 'email');
        String? password = await storage.read(key: 'password');
        await AuthService().signIn(email!, password!).then((value) {
          callback();
        });
        // ignore: unused_catch_clause
      } on FirebaseAuthException catch (error) {
        return null;
      }
    } else if (auth == 'google') {
      await AuthService().signInGoogle().then((value) {
        callback();
      });
    }
  }
}
