// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:hajj/pages/faq.dart';

class hajjcategories extends StatelessWidget {
  const hajjcategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hajj-e-Tamattu",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => faqpage(
                                title: "Meena-Arafat-Muzdalfa",
                                isGenderBased: true,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/image/u-ehram.png",
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Step-1",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "Meena-Arafat-Muzdalfa",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xff88704e)),
                          child: Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => faqpage(
                                title: "Rami",
                                isGenderBased: true,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/image/rami.png",
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Step-2",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "Rami",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xff88704e)),
                          child: Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => faqpage(
                                title: "Qurbani",
                                isGenderBased: false,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/image/qurbani.png",
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Step-3",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "Qurbani",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xff88704e)),
                          child: Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => faqpage(
                                title: "Taksir",
                                isGenderBased: true,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/image/u_taksir.png",
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Step-4",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "Taksir",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xff88704e)),
                          child: Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
