// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(""),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/image/kaaba1.jpg",
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.quiz),
            title: Text("Send Your Queries"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: () {},
          ),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            onTap: () {},
          ),
          Divider(
            thickness: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
