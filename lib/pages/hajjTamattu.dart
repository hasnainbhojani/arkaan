// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hajj/pages/infolist.dart';

class Hajjtamattu extends StatefulWidget {
  const Hajjtamattu({super.key});

  @override
  State<Hajjtamattu> createState() => _HajjtamattuState();
}

class _HajjtamattuState extends State<Hajjtamattu> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.none;

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
                AssetImage("assets/image/ht1.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht2.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht3.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht4.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht5.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht6.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht7.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/ht8.png"),
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
    ;
  }
}
