// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hajj/pages/infolist.dart';

class Meccamadinah extends StatefulWidget {
  const Meccamadinah({super.key});

  @override
  State<Meccamadinah> createState() => _MeccamadinahState();
}

class _MeccamadinahState extends State<Meccamadinah> {
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
                AssetImage("assets/image/mm1.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/mm2.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/mm3.png"),
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
