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
            colorScheme: ColorScheme.fromSwatch().copyWith(
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
              error: const Color(0xFFFF0000),
              onSurfaceVariant: const Color(0xFFD8D8D8),
              inverseSurface: const Color(0xFF00CA00),
              onPrimaryContainer: const Color(0xFF262F5F),
              onSecondaryContainer: const Color(0xFF4E567D),
              primaryContainer: const Color(0xFFFA00FF),
            ),
          ),
          initialRoute: Routes.signInPage,
          getPages: Pages.pages,
        );
      },
    );
  }
}
