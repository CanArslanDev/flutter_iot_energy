import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: Align(
                child: Image.asset(
                  'assets/images/pp_icon.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.w),
              child: Text(
                accountName,
                style: pageTitleTextStyle.copyWith(fontSize: 6.w),
              ),
            ),
            Text(
              accountMail,
              style: GoogleFonts.inter(
                color: Theme.of(Get.context!).colorScheme.onTertiary,
                fontSize: 4.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.phone,
                    size: 5.w,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    accountPhone,
                    style: GoogleFonts.inter(
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                      fontSize: 4.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await AuthService().signOut();
                await Get.offAllNamed<Object>(Routes.signInPage);
              },
              child: Container(
                height: 10.w,
                width: 27.w,
                margin: EdgeInsets.only(top: 3.w),
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.inter(
                      color: Theme.of(Get.context!).colorScheme.onBackground,
                      fontSize: 4.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
