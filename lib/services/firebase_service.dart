import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_iot_energy/services/value_service.dart';

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

  Future<int> getTotalDeviceCount(String accountId) async {
    var collectionuser = _firestore.collection('users');
    var docSnapshotuser = await collectionuser.doc(accountId).get();
    if (docSnapshotuser.exists) {
      Map<String, dynamic>? datauser = docSnapshotuser.data();
      return datauser?['totalDeviceCount'];
    }
    return 0;
  }

  Future<int> getTotalActiveSceneCount(String accountId) async {
    var collectionuser = _firestore.collection('users');
    var docSnapshotuser = await collectionuser.doc(accountId).get();
    if (docSnapshotuser.exists) {
      Map<String, dynamic>? datauser = docSnapshotuser.data();
      return datauser?['totalActiveScene'];
    }
    return 0;
  }

  void addDevice(String deviceName, String deviceId, int deviceType) async {
    var collection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    collection.add({
      'deviceName': deviceName,
      'deviceId': deviceId,
      'deviceType': deviceType,
    });
    var collectionuser = FirebaseFirestore.instance.collection('users');
    collectionuser
        .doc(accountId) // <-- Doc ID where data should be updated.
        .update({'totalDeviceCount': accountTotalDevices + 1});
  }

  Future<bool> getDeviceFound(String id, String type) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/voltage').get();
    if (snapshot.exists) {
      final ref1 = FirebaseDatabase.instance.ref();
      final snapshot1 = await ref1.child('devices/$id/type').get();
      if (snapshot1.exists) {
        if (snapshot1.value.toString() == type) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<double> getDeviceVoltage(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/voltage').get();
    if (snapshot.exists) {
      return double.parse(snapshot.value.toString());
    } else {
      return 0;
    }
  }

  Future<double> getDeviceWatt(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/watt').get();
    if (snapshot.exists) {
      return double.parse(snapshot.value.toString());
    } else {
      return 0;
    }
  }

  Future<double> getDeviceChargePercentage(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/percentage').get();
    if (snapshot.exists) {
      return double.parse(snapshot.value.toString());
    } else {
      return 0;
    }
  }

  Future<double> getDeviceAmpere(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/ampere').get();
    if (snapshot.exists) {
      return double.parse(snapshot.value.toString());
    } else {
      return 0;
    }
  }

  Future<String> getDeviceDate(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/date').get();
    if (snapshot.exists) {
      DateTime dt = DateTime.parse(snapshot.value.toString());
      print(
          "${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}:${dt.second}");
      DateTime dt2 = DateTime.now();
      print(
          "${dt2.year}-${dt2.month}-${dt2.day} ${dt2.hour}:${dt2.minute}:${dt2.second}");
      return snapshot.value.toString();
    } else {
      return "";
    }
  }

  Future<int> getAllDevicesVoltage(String accountId) async {
    double totalVoltage = 0;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    QuerySnapshot querySnapshot = await collectionRef.get();
    var mappedList = querySnapshot.docs
        .map((doc) async => await getDeviceVoltage(doc['deviceId']));
    List valueList = await Future.wait(mappedList);
    for (var element in valueList) {
      totalVoltage += element;
    }
    return totalVoltage.toInt();
  }
}
