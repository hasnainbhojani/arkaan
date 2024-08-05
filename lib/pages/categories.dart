// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class categories extends StatelessWidget {
  const categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
        ),
        body: Padding(
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
        ));
  }
}
