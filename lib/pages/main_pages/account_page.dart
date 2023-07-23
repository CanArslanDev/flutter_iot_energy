import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
                await Get.offAndToNamed<Object>(Routes.signInPage);
              },
              child: const Text(''),
            )
          ],
        ),
      ),
    );
  }
}
