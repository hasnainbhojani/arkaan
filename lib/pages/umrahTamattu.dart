// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hajj/pages/infolist.dart';
import 'package:hajj/pages/qna.dart';

class Umrahtamattu extends StatefulWidget {
  const Umrahtamattu({super.key});

  @override
  State<Umrahtamattu> createState() => _UmrahtamattuState();
}

class _UmrahtamattuState extends State<Umrahtamattu> {
  NavigationRailLabelType labelType = NavigationRailLabelType.none;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          indicatorColor: Colors.transparent,
          selectedIconTheme:
              CupertinoIconThemeData(color: Colors.amber, size: 40),
          unselectedIconTheme:
              CupertinoIconThemeData(size: 40, color: Colors.white),
          destinations: [
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ut_ehram.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ut_tawaf.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ut_namaz.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ut_saee.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ut_taksir.png"),
              ),
              label: Text(""),
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelType: labelType,
        ),
        Expanded(child: Infolist(selectedIndex: _selectedIndex))
      ],
    );
  }
}
