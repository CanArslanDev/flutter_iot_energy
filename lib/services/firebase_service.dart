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

    final listDatabase = {
      'deviceType': deviceType,
      'hour': hour,
      'minute': minute,
      'day': day,
      'plan': plan,
      'enable': true,
      'timestamp': DateTime.now(),
      'sceneName': 'Scene',
      'fromDevice': deviceName,
      'fromDeviceId': deviceId,
    };
    final listRealtimeDatabase = {
      'deviceType': deviceType,
      'hour': hour,
      'minute': minute,
      'day': day,
      'plan': plan,
      'enable': true,
      'timestamp': DateTime.now().toString(),
    };

//set scene firestore database
    final sceneRef = FirebaseFirestore.instance
        .collection('users/$accountId/devices/$deviceDataId/scenes')
        .doc('scene_$recentlySceneCount');
    await sceneRef.set(listDatabase);

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
    final getCountCollection =
        FirebaseFirestore.instance.collection('users/$accountId/devices');
    final docSnapshot = await getCountCollection.doc(deviceDataId).get();
    final getCountdata = docSnapshot.data();
    return getCountdata?['totalSceneCount'] as int;
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
    final sceneRef = FirebaseFirestore.instance
        .collection('users/$accountId/devices/$deviceId/scenes/')
        .doc(sceneId);
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId/$sceneId');
    await sceneRealtimeRef.update({'enable': value});
    await sceneRef.update({'enable': value});
  }

  Future<void> setDeviceSceneClockValue(
    String deviceId,
    String sceneId,
    int hour,
    int minute,
  ) async {
    final sceneRef = FirebaseFirestore.instance
        .collection('users/$accountId/devices/$deviceId/scenes/')
        .doc(sceneId);
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId/$sceneId');
    await sceneRealtimeRef.update({'hour': hour, 'minute': minute});
    await sceneRef.update({'hour': hour, 'minute': minute});
  }

  Future<void> setDeviceScenePlanValue(
    String deviceId,
    String sceneId,
    int value,
  ) async {
    final sceneRef = FirebaseFirestore.instance
        .collection('users/$accountId/devices/$deviceId/scenes/')
        .doc(sceneId);
    final sceneRealtimeRef =
        FirebaseDatabase.instance.ref().child('devices/$deviceId/$sceneId');
    await sceneRealtimeRef.update({
      'plan': value,
    });
    await sceneRef.update({
      'plan': value,
    });
  }

  Future<Map<String, dynamic>?> getDeviceScene(
    String deviceId,
    String sceneId,
  ) async {
    final sceneRef = FirebaseFirestore.instance
        .collection('users/$accountId/devices/$deviceId/scenes/');
    final sceneRefSnapshot = await sceneRef.doc(sceneId).get();
    return sceneRefSnapshot.data();
  }

  Future<void> deleteDeviceScene(
    String deviceId,
    String sceneId,
  ) async {
    final sceneRef = FirebaseFirestore.instance
        .collection('users/$accountId/devices/$deviceId/scenes/');
    await sceneRef.doc(sceneId).delete();

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
      final scenesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(accountId)
          .collection('devices')
          .doc(deviceId)
          .collection('scenes')
          .get();
      scenesSnapshot.docs.map((doc) {
        value++;
      }).toList();
    }
    return value;
  }
}
