import 'package:flutter/material.dart';
import 'package:kmunity_se/Screens/Login_screen.dart';
import 'package:kmunity_se/Screens/Menu_screen.dart';
import 'package:kmunity_se/Screens/User_screen.dart';
import 'package:get/get.dart';
import 'package:kmunity_se/Screens/home_screen.dart';
import 'package:kmunity_se/Screens/mailbox_screen.dart';
import 'package:kmunity_se/constant/constant.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({super.key});

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  bool isHomeOutline = true;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0), 
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 50,
                color: Color.fromARGB(255, 255, 186, 130),
                offset: Offset(0, 0),
              )
            ],
          ),
          child: NavigationBar(
            // currentIndex: _currentIndex,

            height: 92,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,

            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.mail_outlined),
                label: 'Mailbox',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'User',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    homescreen(),
    mailscreen(),
    userscreen(),
    menuscreen(),
  ];
}
