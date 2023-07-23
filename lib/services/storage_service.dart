import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Storage Services
class StorageService {
  final storage = const FlutterSecureStorage();

  ///set meail password
  Future<void> setEmailPasswordAuth(String email, String password) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
    await storage.write(key: 'auth', value: 'email');
  }

  ///set Google Auth
  Future<void> setGoogleAuth() async {
    await storage.write(key: 'auth', value: 'google');
  }

  Future<void> getAutomaticSignAuth(
    VoidCallback callback,
    VoidCallback errorCallback,
    void Function() widget,
  ) async {
    widget();
    final auth = await storage.read(key: 'auth');
    if (auth == 'email') {
      try {
        final email = await storage.read(key: 'email');
        final password = await storage.read(key: 'password');
        await AuthService().signIn(email!, password!).then((value) {
          callback();
        });
        // ignore: unused_catch_clause
      } catch (error) {
        errorCallback();
      }
    } else if (auth == 'google') {
      await AuthService().signInGoogle().then((value) {
        callback();
      });
    } else {
      errorCallback();
    }
  }
}
