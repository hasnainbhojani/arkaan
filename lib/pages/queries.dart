// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Queries extends StatefulWidget {
  const Queries({super.key});

  @override
  State<Queries> createState() => _QueriesState();
}

class _QueriesState extends State<Queries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ask your Question",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.3),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                hintText: "Type your Name",
                label: Text(
                  "Name",
                  style: TextStyle(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.person_outlined),
                focusColor: Color(0xff88704e),
              ),
              keyboardType: TextInputType.name,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.3),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                hintText: "Type your Email",
                label: Text(
                  "Email",
                  style: TextStyle(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.email_rounded),
                focusColor: Color(0xff88704e),
              ),
              keyboardType: TextInputType.emailAddress,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.3),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                hintText: "Type your phone number",
                label: Text(
                  "Phone number",
                  style: TextStyle(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.phone),
                focusColor: Color(0xff88704e),
              ),
              keyboardType: TextInputType.phone,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.3),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                label: Text(
                  "Topic",
                  style: TextStyle(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.topic),
                focusColor: Color(0xff88704e),
              ),
              keyboardType: TextInputType.text,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 40),
                fillColor: Colors.white.withOpacity(0.3),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xff88704e)),
                ),
                label: Text(
                  "Your Query",
                  style: TextStyle(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.text_snippet),
                focusColor: Color(0xff88704e),
              ),
              keyboardType: TextInputType.text,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    side: BorderSide(color: Color(0xff88704e), width: 2)),
                onPressed: () {},
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
