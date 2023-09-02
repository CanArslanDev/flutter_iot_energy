import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
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

  Future<void> setDeviceCharging(String id, int charging) async {
    final deviceRef = FirebaseDatabase.instance.ref().child('devices/$id');
    if (charging == -1) {
      await deviceRef.update({'charging': false});
    } else {
      await deviceRef.update({'charging': true});
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

  Future<void> addDevice(
    String deviceName,
    String deviceId,
    int deviceType,
  ) async {
    final collection = FirebaseFirestore.instance
        .collection('users/$accountId/devices')
        .doc(deviceId);
    await collection.set({
      'deviceName': deviceName,
      'deviceId': deviceId,
      'deviceType': deviceType,
      'totalSceneCount': 0,
      'recentlySceneCount': 0,
    });
    final collectionuser = FirebaseFirestore.instance.collection('users');
    await collectionuser
        .doc(accountId)
        .update({'totalDeviceCount': accountTotalDevices + 1});
    await setAccountModuleList(
      value: await getDeviceModuleId(deviceId),
      add: true,
    );
    // await collectionuser
    //     .doc(accountId)
    //     .update({'totalDeviceCount': accountTotalDevices + 1});
  }

  Future<List<String>> getAccountModuleList() async {
    final collectionuser =
        FirebaseFirestore.instance.collection('users').doc(accountId);
    final docSnapshotuser = await collectionuser.get();
    final doc = docSnapshotuser.data();
    if (doc!['moduleList'] != null) {
      return List<String>.from(doc['moduleList'] as List);
    }
    return [];
  }

  Future<void> setAccountModuleList({
    required String value,
    required bool add,
  }) async {
    final collectionuser =
        FirebaseFirestore.instance.collection('users').doc(accountId);
    final docSnapshotuser = await collectionuser.get();
    final doc = docSnapshotuser.data();
    if (doc!['moduleList'] != null) {
      if (add == true) {
        final moduleList = doc['moduleList'] as List;
        if (moduleList.contains(value)) {
          return;
        }
        moduleList.add(value);
        await collectionuser.update({'moduleList': moduleList});
      } else {
        final moduleList = doc['moduleList'] as List..remove(value);

        await collectionuser.update({'moduleList': moduleList});
      }
    } else {
      if (add == true) {
        final moduleList = [value];

        await collectionuser.update({'moduleList': moduleList});
      }
    }

    // final docSnapshot = await docRef.get();
    // final List<String> moduleList =
    //     List<String>.from(docSnapshot.data!['moduleList']);
    // moduleList.add(value);

    // await docRef.update({'moduleList': moduleList});
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
      final charging = data['charging'];
      final type = data['type'];
      final voltage = data['voltage'];
      final watt = data['watt'];
      final percentage = data['percentage'];
      final ampere = data['ampere'];
      final moduleId = data['module_id'];
      final date = DeviceService().calculateOnlineDevice(
        DateTime.parse(data['date'] as String),
        DateTime.now(),
      );

      return {
        'voltage': voltage,
        'watt': watt,
        'percentage': percentage,
        'ampere': ampere,
        'date': date,
        'power': power,
        'type': type,
        'charging': charging,
        'module_id': moduleId,
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

  Future<void> setDeviceSceneList(
    String id,
    String sceneId,
    dynamic added,
  ) async {
    var sceneList = '';
    //Get data
    final readRef = FirebaseDatabase.instance.ref();
    final readSnapshot = await readRef.child('devices/$id/sceneList').get();
    if (readSnapshot.exists) {
      if (!readSnapshot.value.toString().contains('{')) {
        sceneList = readSnapshot.value.toString();
      }
    }
    //Set data
    final writeRef = FirebaseDatabase.instance.ref().child('devices/$id');
    if (added == true) {
      await writeRef.update({'sceneList': '$sceneList$sceneId,'});
    } else {
      sceneList = sceneList.replaceAll('$sceneId,', '');
      await writeRef.update({'sceneList': sceneList});
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

  Future<String> getDeviceModuleId(
    String id,
  ) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$id/module_id').get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return '';
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

  Future<void> addDeviceScene(
    String accountId,
    String deviceDataId,
    String deviceId,
    String deviceName,
    int deviceType,
    int hour,
    int minute,
    int day,
    int plan,
  ) async {
// get-set scene count firestore database
    await setDeviceIncreaseSceneCount(deviceDataId);
    final recentlySceneCount =
        await setDeviceIncreaseRecentlySceneCount(deviceDataId);
//set list

    final listRealtimeDatabase = {
      'deviceType': deviceType,
      'hour': hour,
      'minute': minute,
      'day': day,
      'plan': plan,
      'enable': true,
      'timestamp': DateTime.now().toString(),
    };

// set scene realtime database
    final sceneRealtimeRef = FirebaseDatabase.instance
        .ref()
        .child('devices/$deviceId/scene_$recentlySceneCount');

    await sceneRealtimeRef.update(listRealtimeDatabase);
    await setDeviceSceneList(deviceId, 'scene_$recentlySceneCount', true);
  }

  Future<int> setDeviceIncreaseSceneCount(String deviceDataId) async {
    final getCountCollection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    final docSnapshot = await getCountCollection.doc(deviceDataId).get();
    final getCountdata = docSnapshot.data();
    final totalSceneCount = (getCountdata?['totalSceneCount'] as int) + 1;
    await getCountCollection
        .doc(deviceDataId)
        .update({'totalSceneCount': totalSceneCount});
    return totalSceneCount;
  }

  Future<int> getDeviceTotalSceneCount(String deviceDataId) async {
    final c =
        (await FirebaseService().getDeviceSceneList(deviceDataId)).split(',');
    return c.length - 1;
  }

  Future<String> getDeviceSceneList(String deviceDataId) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('devices/$deviceDataId/sceneList').get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return '';
    }
  }

  Future<Map<String, dynamic>> getDeviceScene(
    String deviceDataId,
    String scene,
  ) async {
    final reference = FirebaseDatabase.instance
        .ref()
        .child('devices/$deviceDataId')
        .child(scene);

    final event = await reference.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      final data = snapshot.value! as Map;
      final day = data['day'];
      final deviceType = data['deviceType'];
      final enable = data['enable'];
      final hour = data['hour'];
      final minute = data['minute'];
      final plan = data['plan'];
      final timestamp = data['timestamp'];

      return {
        'sceneId': scene,
        'day': day,
        'deviceType': deviceType,
        'enable': enable,
        'hour': hour,
        'minute': minute,
        'plan': plan,
        'timestamp': timestamp,
      };
    } else {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getDeviceSceneAllList(
    String deviceId,
  ) async {
    final devices = <Map<String, dynamic>>[];
    final c = (await FirebaseService().getDeviceSceneList(deviceId)).split(',');
    for (var i = 0; i < c.length - 1; i++) {
      devices.add(await FirebaseService().getDeviceScene(deviceId, c[i]));
    }
    return devices;
  }

  Future<bool> getAccountDeviceIsExists(String deviceId) async {
    final getCountCollection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    final docSnapshot = await getCountCollection.doc(deviceId).get();
    if (docSnapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> setDeviceIncreaseRecentlySceneCount(String deviceDataId) async {
    final getCountCollection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    final docSnapshot = await getCountCollection.doc(deviceDataId).get();
    final getCountdata = docSnapshot.data();
    final recentlySceneCount = (getCountdata?['recentlySceneCount'] as int) + 1;
    await getCountCollection
        .doc(deviceDataId)
        .update({'recentlySceneCount': recentlySceneCount});
    return recentlySceneCount;
  }

  Future<int> setDeviceDecreaseSceneCount(String deviceDataId) async {
    final getCountCollection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    final docSnapshot = await getCountCollection.doc(deviceDataId).get();
    final getCountdata = docSnapshot.data();
    final totalSceneCount = (getCountdata?['totalSceneCount'] as int) - 1;
    await getCountCollection
        .doc(deviceDataId)
        .update({'totalSceneCount': totalSceneCount});
    return totalSceneCount;
  }

  Future<void> setDeviceSceneEnableValue(
    String deviceId,
    String sceneId,
    dynamic value,
  ) async {
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId/$sceneId');
    await sceneRealtimeRef.update({'enable': value});
  }

  Future<void> setDeviceSceneClockValue(
    String deviceId,
    String sceneId,
    int hour,
    int minute,
  ) async {
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId/$sceneId');
    await sceneRealtimeRef.update({'hour': hour, 'minute': minute});
  }

  Future<void> setDeviceScenePlanValue(
    String deviceId,
    String sceneId,
    int value,
  ) async {
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId/$sceneId');
    await sceneRealtimeRef.update({
      'plan': value,
    });
  }

  Future<void> deleteDeviceScene(
    String deviceId,
    String sceneId,
  ) async {
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId');
    await sceneRealtimeRef.child(sceneId).remove();
    await setDeviceDecreaseSceneCount(deviceId);
    await setDeviceSceneList(deviceId, sceneId, false);
  }

  Future<int> getTotalScene() async {
    var value = 0;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(accountId)
        .collection('devices')
        .get();
    final devicesAll = snapshot.docs.map((doc) => doc.id).toList();
    for (final deviceId in devicesAll) {
      final c =
          (await FirebaseService().getDeviceSceneList(deviceId)).split(',');
      value += c.length - 1;
      // final scenesSnapshot = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(accountId)
      //     .collection('devices')
      //     .doc(deviceId)
      //     .collection('scenes')
      //     .get();
      // scenesSnapshot.docs.map((doc) {
      //   value++;
      // }).toList();
    }
    return value;
  }
}
