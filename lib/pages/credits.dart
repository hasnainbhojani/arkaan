import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  const Credits({super.key});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  var desc =
      '''This app is a heartfelt gift to the 14 Masoomin a.s , with special reverence to Bibi Fatema Zehra s.a. We hope it brings blessings and spiritual growth to all users.

Special Thanks to:

Yasin Merchant
(Haniya Business Solution)

Insya Mohammadraza Govani
(UI Designer)

Mohammad Aabid
(API and Web Developer)

Hasnain Raza Bhojani
(App Developer)

We may also remember and pray for the souls of all Marhumin.
     ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credits"),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/background.jpg"),
                fit: BoxFit.fitHeight)),
        child: Container(
          margin: EdgeInsets.all(25),
          color: Colors.black.withOpacity(0.7),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    desc,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
