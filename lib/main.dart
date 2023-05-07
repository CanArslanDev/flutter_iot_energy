import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/routes/pages.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'Energy',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
                primary: const Color(0xFFFFA800),
                onPrimary: const Color(0xFFFFBA0C),
                secondary: const Color(0xFF000000),
                onSecondary: const Color(0xFF5E5E5E),
                onSurface: const Color(0xFFCCCCCC),
                background: const Color(0xFFF5F3F2),
                onBackground: Colors.white,
                outline: const Color(0xFF5E5E5E),
                onTertiary: const Color(0xDD3B3B3B),
                tertiary: const Color(0xFF0099FF),
                error: Color.fromARGB(255, 255, 0, 0)),
          ),
          initialRoute: Routes.signInPage,
          getPages: Pages.pages,
        );
      },
    );
  }
}
