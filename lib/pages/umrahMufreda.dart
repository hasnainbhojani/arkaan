// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hajj/pages/infolist.dart';

class Umrahmufreda extends StatefulWidget {
  const Umrahmufreda({super.key});

  @override
  State<Umrahmufreda> createState() => _UmrahmufredaState();
}

class _UmrahmufredaState extends State<Umrahmufreda> {
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
                AssetImage("assets/image/um1.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/um2.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/um3.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/um4.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/um5.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/um6.png"),
              ),
              label: Text(""),
            ),
            NavigationRailDestination(
              icon: ImageIcon(
                AssetImage("assets/image/um7.png"),
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
