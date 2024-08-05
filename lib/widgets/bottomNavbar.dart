// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/main.dart';
import 'package:hajj/pages/counter.dart';
import 'package:hajj/widgets/navbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:hajj/pages/home.dart';

class navMenu extends StatelessWidget {
  const navMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      // Title
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Arkaan"),
      ),
      drawer: Navbar(),
      // Bottom Navigation Bar
      bottomNavigationBar: Obx(
        () => NavigationBar(
            indicatorColor: Color(0xff88704e),
            height: 70,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                  icon: Icon(CupertinoIcons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.book_fill), label: 'Ayatullah'),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.add_circled_solid),
                  label: 'Counter'),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.person_fill), label: 'Profile'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const MyHomePage(),
    Container(
      color: Colors.purple,
    ),
    const counter(),
    Container(
      color: Colors.purple,
    )
  ];
}
