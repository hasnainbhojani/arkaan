// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/categories.dart';
import 'package:hajj/widgets/navbar.dart';
import 'package:hajj/widgets/bottomNavbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => categories()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff2d9596).withOpacity(0.8),
                Color(0xff9ad0c2).withOpacity(0.9)
              ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(10, 10),
                  blurRadius: 10,
                  color: Color(0xff166d3b).withOpacity(0.2),
                )
              ]),
          child: Container(
              padding: EdgeInsets.only(left: 25, top: 25, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Hajj Rituals",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get the Answer",
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "for your Question",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 72, 121, 94),
                                blurRadius: 5,
                              )
                            ]),
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    ));
  }
}
