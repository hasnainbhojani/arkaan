// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/namazTime.dart';
import 'package:hajj/pages/profile.dart';
import 'package:hajj/pages/dua.dart';
import 'package:hajj/pages/search.dart';
import 'package:hajj/pages/sections.dart';
import 'package:hajj/pages/ziyarat.dart';
import 'package:hajj/widgets/navbar.dart';

class navMenu extends StatefulWidget {
  const navMenu({super.key});

  @override
  State<navMenu> createState() => _navMenuState();
}

class _navMenuState extends State<navMenu> {
  int _currentIndex = 0;

  final tabs = [
    // Umrahtamattu
    Sections(id: 1),
    // Hajjtamattu
    Sections(id: 2),
    // Umrahmufreda
    Sections(id: 3),
    // Meccamadinah
    Sections(id: 4),
    Ziyarat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Heading Image
            Image(
              image: AssetImage(
                "assets/image/arkan.png",
              ),
              width: 100,
            ),
            Row(
              children: [
                // Namaztime feature Icon
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrayerTimesScreen()));
                  },
                  child: Icon(
                    CupertinoIcons.time,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                // Search Feature Icon
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  child: Icon(
                    CupertinoIcons.search,
                    size: 20,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      drawer: Navbar(),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        iconSize: 24, // Adjust if needed
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
            color: Colors
                .amber), // No need to use CupertinoIconThemeData unless specific
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize:
                  MainAxisSize.min, // Make sure to keep only min space
              children: [
                ImageIcon(
                  AssetImage("assets/image/umrahtamattubtmnvb.png"),
                  size: 20, // Adjust icon size if needed
                ),
                SizedBox(height: 2), // Reduced spacing
                Text(
                  "Umrah Tamattu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9), // Adjust font size
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/hajjtamattubtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Hajj Tamattu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/umrahmufredabtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Umrah Mufreda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/meccamadinabtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Mecca Madinah",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/ziyaratbtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Ziyarat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Sticker
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.all(2),
              child: Image.asset("assets/image/sticker.png")),

          // Tawaf Dua & Saee Dua Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dua(
                                name: "Tawaf Dua",
                                id: 39,
                              )));
                },
                child: Row(
                  children: [
                    Container(
                        child: Image.asset(
                      "assets/image/kaaba1.png",
                      fit: BoxFit.cover,
                      height: 26,
                      width: 26,
                      alignment: Alignment.topCenter,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Tawaf Dua",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dua(
                                name: "Sa'ee Dua",
                                id: 40,
                              )));
                },
                child: Row(
                  children: [
                    Container(
                        child: Image.asset(
                      "assets/image/mountain1.png",
                      fit: BoxFit.cover,
                      height: 26,
                      width: 26,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sa`ee Dua",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(child: tabs[_currentIndex]),
        ],
      ),
    );
  }
}
