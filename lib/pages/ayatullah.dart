// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:flutter/material.dart';

class ayatullah extends StatefulWidget {
  const ayatullah({super.key});

  @override
  State<ayatullah> createState() => _ayatullahState();
}

class _ayatullahState extends State<ayatullah> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioMenuButton(
                    value: "Ayatullah Sistani",
                    groupValue: selected,
                    onChanged: (value) {
                      selected = value!;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image(
                            image: AssetImage("assets/image/sistani.jpg"),
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ayatullah Sistani(D.a.)",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioMenuButton(
                    value: "Ayatullah Khamenei",
                    groupValue: selected,
                    onChanged: (value) {
                      selected = value!;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image(
                            image: AssetImage("assets/image/khamenei.webp"),
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ayatullah Khamenei(D.a.)",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
