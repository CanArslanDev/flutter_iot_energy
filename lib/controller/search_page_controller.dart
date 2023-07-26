import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:get/get.dart';

class SearchPageController extends BaseController {
  String searchTextController = '';

  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> matchingDevices =
      RxList();
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> matchingScenes = RxList();
  Future<void> searchData(String searchText) async {
    searchTextController = searchText;
    if (searchText.isEmpty) {
      matchingDevices.value = [];
      matchingScenes.value = [];
      return;
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(accountId)
        .collection('devices')
        .where('deviceName')
        .get();

    final devices = snapshot.docs
        .map((doc) => doc)
        .where(
          (deviceName) => deviceName['deviceName']
              .toString()
              .toLowerCase()
              .startsWith(searchText.toLowerCase()),
        )
        .toList();

    final devicesAll = snapshot.docs.map((doc) => doc.id).toList();
    var scenes = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
    for (final deviceId in devicesAll) {
      final scenesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(accountId)
          .collection('devices')
          .doc(deviceId)
          .collection('scenes')
          .where('sceneName')
          .get();
      final tempScenes = scenesSnapshot.docs
          .map((doc) {
            return doc;
          })
          .where(
            (sceneId) => sceneId['sceneName']
                .toString()
                .toLowerCase()
                .startsWith(searchText.toLowerCase()),
          )
          .toList();
      scenes += tempScenes;
    }
    if (searchTextController.isNotEmpty) {
      matchingDevices.value = devices;
      matchingScenes.value = scenes;
    } else {
      matchingDevices.value = [];
      matchingScenes.value = [];
    }
  }
//   @override
//   void onInit() {
//     super.onInit();
//   }
}
