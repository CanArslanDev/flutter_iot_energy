import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/main_page_controller.dart';
import 'package:get/get.dart';

class MainPage extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MainPage')),
        body: SafeArea(child: Text('MainController')));
  }
}
