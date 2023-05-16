import 'package:cloud_firestore/cloud_firestore.dart';

String accountUsername = "";
String accountName = "";
String accountSurname = "";
String accountMail = "";
String accountPhone = "";
String accountId = "";
int accountTotalDevices = 0;
int accountTotalActiveScene = 0;

class ValueService {
  initializeLogin(
      accountNameVoid, accountMailVoid, accountPhoneVoid, accountIdVoid) async {
    var collectionuser = FirebaseFirestore.instance.collection('users');
    var docSnapshotuser = await collectionuser.doc(accountIdVoid).get();
    if (docSnapshotuser.exists) {
      Map<String, dynamic>? datauser = docSnapshotuser.data();
      accountTotalDevices = datauser?['totalDeviceCount'];
      accountTotalActiveScene = datauser?['totalActiveScene'];
    }
    accountUsername = accountNameVoid;
    List<String> username = accountNameVoid.split(" ");
    accountName = username[0];
    accountSurname = username[1];
    accountMail = accountMailVoid;
    accountPhone = accountPhoneVoid ?? "";
    accountId = accountIdVoid;
  }

  changeTotalDevices(int number) {
    accountTotalDevices = number;
  }

  changeTotalScene(int number) {
    accountTotalActiveScene = number;
  }
}
