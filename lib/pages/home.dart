// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajj/pages/categories.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Find the ease of praying!",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            // Namaz Location and Timing Section
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: Color(0xff88704e),
                    width: 2,
                  )),
              child: Column(
                children: [
                  // Location for Namaz Timing
                  Stack(
                    children: [
                      Container(
                        height: 78,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/image/timedesign.png")),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fajr-Mecca",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Text("1hr 24 min",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  // Timing for Namaz
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Fajr",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            Icon(
                              CupertinoIcons.cloud_sun_fill,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Text(
                              "04:30",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Zuhr",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            Icon(
                              CupertinoIcons.sun_max_fill,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Text(
                              "12:45",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Asr",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            Icon(
                              CupertinoIcons.sunset,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Text(
                              "14.50",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Maghrib",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            Icon(
                              CupertinoIcons.cloud_moon_fill,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Text(
                              "17:26",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Isha",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                            Icon(
                              CupertinoIcons.moon_stars_fill,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Text(
                              "18:36",
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Recently Played Section
            SizedBox(
              height: 15,
            ),
            Text(
              "Recently Played",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 117,
                      width: 112,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.white.withOpacity(0.5)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xff88704e),
                            width: 2,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "How to wear ehraam?",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(CupertinoIcons.arrow_right_circle_fill)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 117,
                      width: 112,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.white.withOpacity(0.5)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xff88704e),
                            width: 2,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "How to wear ehraam?",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(CupertinoIcons.arrow_right_circle_fill)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 117,
                      width: 112,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.white.withOpacity(0.5)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xff88704e),
                            width: 2,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "How to wear ehraam?",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(CupertinoIcons.arrow_right_circle_fill)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 117,
                      width: 112,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.white.withOpacity(0.5)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xff88704e),
                            width: 2,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "How to wear ehraam?",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(CupertinoIcons.arrow_right_circle_fill)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Hajj Guide Section
            SizedBox(
              height: 20,
            ),
            InkWell(
              splashColor: Colors.white.withOpacity(0.1),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const categories()));
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/kaaba2.jpg"),
                        opacity: 0.3,
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                      color: Color(0xff88704e),
                      width: 2,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Hajj Guide",
                      style: TextStyle(fontSize: 36, color: Colors.white),
                    ),
                    Icon(CupertinoIcons.arrow_right)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
