import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hajj/pages/details.dart';
import 'package:hajj/pages/infolist.dart';

class Ziyarat extends StatefulWidget {
  const Ziyarat({super.key});

  @override
  State<Ziyarat> createState() => _ZiyaratState();
}

class _ZiyaratState extends State<Ziyarat> {
  NavigationRailLabelType labelType = NavigationRailLabelType.none;
  int _selectedIndex = 1;
  List _items = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("assets/video/example.json");
    final data = await json.decode(response);

    setState(() {
      _items = data["items"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.ac_unit),
              );
            },
          ),
        ),
        Expanded(flex: 5, child: Infolist(selectedIndex: _selectedIndex))
      ],
    );
  }
}

/*
Row(
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 70,
                    child: ListTile(
                      leading: Icon(
                        Icons.abc,
                      ),
                      tileColor: Colors.blue,
                      selectedColor: Colors.amber,
                      selected: true,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Expanded(child: Infolist(selectedIndex: _selectedIndex))
      ],
    );
*/