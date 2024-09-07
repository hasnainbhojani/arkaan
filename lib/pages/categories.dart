// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/hajjcategories.dart';
import 'package:hajj/pages/umrah.dart';

class categories extends StatelessWidget {
  const categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hajj Guide"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const umrah()));
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff88704e), Color(0xff221c14)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(width: 1, color: Color(0xff88704e))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Umrah-E-Tamattu",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            Text(
                              "Step-1",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, right: 20, left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const hajjcategories()));
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff88704e), Color(0xff221c14)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(width: 1, color: Color(0xff88704e))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Hajj-E-Tamattu",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            Text(
                              "Step-1",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

/*Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 85,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff2d9596).withOpacity(0.8),
                    Color(0xff9ad0c2).withOpacity(0.9)
                  ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
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
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      "Hajj Ehkaam",
                      style: TextStyle(fontSize: 22),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: 25,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
        )*/