// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hajj/pages/namazTime.dart';
import 'package:hajj/pages/queries.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/logo.png",
                  height: 50,
                  width: 47,
                ),
                SizedBox(
                  width: 25,
                ),
                Flexible(
                  child: Text(
                    "The Comprehensive Guide to Hajj Rituals",
                    style: TextStyle(color: Colors.amber),
                  ),
                )
              ],
            ),
          ),
          Image.asset("assets/image/sticker.png"),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.access_time_outlined),
            title: Text("Prayer Times"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Namaztime()));
            },
          ),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favourites"),
            onTap: () {},
          ),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.g_translate_outlined),
            title: Text("Translate"),
            onTap: () {},
          ),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.mail_rounded),
            title: Text("Contact Us"),
            onTap: () {},
          ),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share App"),
            onTap: () {},
          ),
          Divider(
            thickness: 0.1,
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
            onTap: () {
              AlertDialog(
                title: Text("Close App"),
                content: Text("Do you really want to close app?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("No")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Yes")),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
