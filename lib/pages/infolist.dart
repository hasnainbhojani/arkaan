import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/details.dart';

class Infolist extends StatefulWidget {
  int selectedIndex;

  Infolist({super.key, required this.selectedIndex});

  @override
  State<Infolist> createState() => _InfolistState();
}

class _InfolistState extends State<Infolist> {
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
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Details()));
        },
        child: _items.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.deepPurpleAccent.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              _items[index]["title"],
                              style: TextStyle(color: Colors.white),
                            ),
                            _items[index]["email"].toString().isEmpty
                                ? Text(
                                    _items[index]["desc"],
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    _items[index]["email"],
                                    style: TextStyle(color: Colors.white),
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _items.length,
              )
            : ElevatedButton(
                onPressed: () {
                  readJson();
                },
                child: Text("Tap"),
              ));
  }
}
