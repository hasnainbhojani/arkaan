import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Infolist extends StatefulWidget {
  int selectedIndex;

  Infolist({super.key, required this.selectedIndex});

  @override
  State<Infolist> createState() => _InfolistState();
}

class _InfolistState extends State<Infolist> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "${widget.selectedIndex}",
      style: TextStyle(color: Colors.white),
    ));
  }
}
