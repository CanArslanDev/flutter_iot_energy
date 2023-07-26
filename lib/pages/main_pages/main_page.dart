import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/home_page_controller.dart';
import 'package:flutter_iot_energy/controller/search_page_controller.dart';
import 'package:flutter_iot_energy/pages/main_pages/account_page.dart';
import 'package:flutter_iot_energy/pages/main_pages/home_page.dart';
import 'package:flutter_iot_energy/pages/main_pages/search_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SearchPage(),
    const AccountPage(),
  ];

  void tabChange(int index) {
    if (index == 0 || index == 2) {
      Get.delete<SearchPageController>();
    } else if (index == 1 || index == 2) {
      Get.delete<HomePageController>();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(Get.context!).colorScheme.onBackground,
                  Theme.of(Get.context!)
                      .colorScheme
                      .onBackground
                      .withOpacity(0),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GNav(
                  gap: 12,
                  activeColor: Theme.of(Get.context!).colorScheme.onBackground,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Theme.of(Get.context!)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.07),
                  color:
                      Theme.of(Get.context!).colorScheme.onSecondaryContainer,
                  tabs: const [
                    GButton(
                      icon: FontAwesomeIcons.house,
                      text: 'Home',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.magnifyingGlass,
                      text: 'Search',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.user,
                      text: 'Account',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: tabChange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
