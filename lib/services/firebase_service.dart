// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_iot_energy/services/value_service.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Get User Value From Firebase
  Future<bool> authGetUser(String accountId) async {
    try {
      var condition = false;
      final collectionuser = _firestore.collection('users');
      final docSnapshotuser = await collectionuser.doc(accountId).get();
      if (docSnapshotuser.exists) {
        condition = true;
      }
      return condition;
    } catch (e) {
      return false;
    }
  }

  ///set Device power Value From Firebase
  Future<void> setDevicePower(String id, int active) async {
    final deviceRef = FirebaseDatabase.instance.ref().child('devices/$id');
    if (active == -1) {
      await deviceRef.update({'power': false});
    } else {
      await deviceRef.update({'power': true});
    }
  }

  ///Get Device Total Device Count Value From Firebase
  Future<int> getTotalDeviceCount(String accountId) async {
    final collectionuser = _firestore.collection('users');
    final docSnapshotuser = await collectionuser.doc(accountId).get();
    if (docSnapshotuser.exists) {
      final datauser = docSnapshotuser.data();
      return datauser?['totalDeviceCount'] as int;
    }
    return 0;
  }

  ///Get Total Active Scene Value From Firebase
  Future<int> getTotalActiveSceneCount(String accountId) async {
    final collectionuser = _firestore.collection('users');
    final docSnapshotuser = await collectionuser.doc(accountId).get();
    if (docSnapshotuser.exists) {
      final datauser = docSnapshotuser.data();
      return datauser?['totalActiveScene'] as int;
    }
    return 0;
  }

  ///add Device Firebase
  Future<void> addDevice(
    String deviceName,
    String deviceId,
    int deviceType,
  ) async {
    final collection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    await collection.add({
      'deviceName': deviceName,
      'deviceId': deviceId,
      'deviceType': deviceType,
    });
    final collectionuser = FirebaseFirestore.instance.collection('users');
    await collectionuser
        .doc(accountId) // <-- Doc ID where data should be updated.
        .update({'totalDeviceCount': accountTotalDevices + 1});
  }

  Future<Map<String, dynamic>> getDeviceAllData(String id) async {
    final reference =
        FirebaseDatabase.instance.ref().child('devices').child(id);

    final event = await reference.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      final data = snapshot.value! as Map;
      var power = false;
      try {
        if (data['power'] as bool == true) {
          power = true;
        } else {
          power = false;
        }
      } catch (e) {
        await setDevicePower(id, 0);
      }
      final voltage = data['voltage'];
      final watt = data['watt'];
      final percentage = data['percentage'];
      final ampere = data['ampere'];
      var date = 'false';
      final dt = DateTime.parse(data['date'] as String);
      final dt2 = DateTime.now();
      if (dt.year == dt2.year &&
          dt.month == dt2.month &&
          dt.day == dt2.day &&
          dt.hour == dt2.hour &&
          dt2.minute - 2 <= dt.minute) {
        date = 'true';
      }
      return {
        'voltage': voltage,
        'watt': watt,
        'percentage': percentage,
        'ampere': ampere,
        'date': date,
        'power': power,
      };
    } else {
      return {};
    }
  }

  ///Get Device Found Value From Firebase
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

  ///Get Device Voltage Value From Firebase
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

  ///Get Device Watt Value From Firebase
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

  ///Get Device Charge Percentage Value From Firebase
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

  ///Get Device Ampere Value From Firebase
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

  ///Get Device Active Value From Firebase
  Future<bool> getDeviceActive(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/date').get();
    if (snapshot.exists) {
      final dt = DateTime.parse(snapshot.value.toString());
      final dt2 = DateTime.now();
      if (dt.year == dt2.year &&
          dt.month == dt2.month &&
          dt.day == dt2.day &&
          dt.hour == dt2.hour &&
          dt2.minute - 2 <= dt.minute) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///Get All Devices Voltage Value From Firebase
  Future<int> getAllDevicesVoltage(String accountId) async {
    var totalVoltage = 0;
    final collectionRef =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    final querySnapshot = await collectionRef.get();
    final mappedList = querySnapshot.docs
        .map((doc) async => getDeviceVoltage(doc['deviceId'] as String));
    final valueList = await Future.wait(mappedList);
    for (final element in valueList) {
      totalVoltage += element.toInt();
    }
    return totalVoltage;
  }
}
