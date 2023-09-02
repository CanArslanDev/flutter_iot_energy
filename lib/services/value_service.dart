import 'package:cloud_firestore/cloud_firestore.dart';

///Set Account Username
String accountUsername = '';

///Set Account Namee
String accountName = '';

///Set Account Surname
String accountSurname = '';

///Set Account Mail
String accountMail = '';

///Set Account Phone
String accountPhone = '';

///Set Account Id
String accountId = '';

///Set Account Devices
int accountTotalDevices = 0;

///Set Account Scenes
int accountTotalActiveScene = 0;

///
class ValueService {
  ///
  Future<void> initializeLogin(
    String accountNameVoid,
    String accountMailVoid,
    String accountPhoneVoid,
    String accountIdVoid,
  ) async {
    final collectionuser = FirebaseFirestore.instance.collection('users');
    final docSnapshotuser = await collectionuser.doc(accountIdVoid).get();
    if (docSnapshotuser.exists) {
      final datauser = docSnapshotuser.data();
      accountTotalDevices = datauser?['totalDeviceCount'] as int;
    }
    accountUsername = accountNameVoid;
    final username = accountNameVoid.split(' ');
    accountName = username[0];
    try {
      accountSurname = username[1];
    } catch (e) {
      accountSurname = '';
    }
    accountMail = accountMailVoid;
    accountPhone = accountPhoneVoid == '' ? '' : accountPhoneVoid;
    accountId = accountIdVoid;
  }

  ///changeTotalDevices
  void changeTotalDevices(int number) {
    accountTotalDevices = number;
  }

  ///changeTotalScene
  void changeTotalScene(int number) {
    accountTotalActiveScene = number;
  }
}
