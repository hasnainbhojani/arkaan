// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/widgets/bottomNavbar.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  var introText = '''ચાર મશહૂર મરજા ના ફતવા મુજબ આસાન તરીકા થી હજ ના મનાસિક''';

  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          (this.context), MaterialPageRoute(builder: ((context) => navMenu())));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pushReplacement((this.context),
              MaterialPageRoute(builder: ((context) => navMenu())));
        },
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/logo.png",
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                introText,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'MuktaVaani'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
