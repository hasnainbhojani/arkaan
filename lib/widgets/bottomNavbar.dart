// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/ayatullah.dart';
import 'package:hajj/pages/counter.dart';
import 'package:hajj/pages/hajjTamattu.dart';
import 'package:hajj/pages/meccaMadinah.dart';
import 'package:hajj/pages/namazTime.dart';
import 'package:hajj/pages/profile.dart';
import 'package:hajj/pages/umrahMufreda.dart';
import 'package:hajj/pages/umrahTamattu.dart';
import 'package:hajj/pages/ziyarat.dart';
import 'package:hajj/widgets/navbar.dart';
import 'package:hajj/pages/home.dart';

class navMenu extends StatefulWidget {
  const navMenu({super.key});

  @override
  State<navMenu> createState() => _navMenuState();
}

class _navMenuState extends State<navMenu> {
  int _currentIndex = 0;

  final tabs = [
    Umrahtamattu(),
    Hajjtamattu(),
    Umrahmufreda(),
    Meccamadinah(),
    Ziyarat()
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
            Image(
              image: AssetImage(
                "assets/image/arkan.png",
              ),
              width: 100,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Namaztime()));
                  },
                  child: Icon(
                    CupertinoIcons.time,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  CupertinoIcons.search,
                  size: 25,
                )
              ],
            ),
          ],
        ),
      ),
      drawer: Navbar(),
      // Bottom Navigation Bar
      bottomNavigationBar: SingleChildScrollView(
        child: SizedBox(
          height: 85,
          child: BottomNavigationBar(
              iconSize: 20,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              currentIndex: _currentIndex,
              selectedLabelStyle: TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible),
              unselectedLabelStyle: TextStyle(
                fontSize: 6,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                overflow: TextOverflow.visible,
              ),
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.amber,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: CupertinoIconThemeData(color: Colors.amber),
              items: [
                BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/image/umrahtamattubtmnvb.png"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Umrah Tamattu",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        )
                      ],
                    ),
                    label: '',
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/image/hajjtamattubtmnvb.png"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hajj Tamattu",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  label: '',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageIcon(
                            AssetImage("assets/image/umrahmufredabtmnvb.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Umrah Mufreda",
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    label: '',
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        children: [
                          ImageIcon(
                            AssetImage("assets/image/meccamadinabtmnvb.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Mecca Madinah",
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    label: '',
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        ImageIcon(
                          AssetImage("assets/image/ziyaratbtmnvb.png"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ziyarat",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        )
                      ],
                    ),
                    label: '',
                    backgroundColor: Colors.black),
              ]),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.all(2),
              child: Image.asset("assets/image/sticker.png")),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      child: Image.asset(
                    "assets/image/kaaba1.png",
                    fit: BoxFit.cover,
                    height: 35,
                    width: 35,
                    alignment: Alignment.topCenter,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tawaf Dua",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                      child: Image.asset(
                    "assets/image/mountain1.png",
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sa`ee Dua",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          Expanded(child: tabs[_currentIndex]),
        ],
      ),
    );
  }
}
