// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:hajj/pages/qna.dart';

class faqpage extends StatefulWidget {
  final String title;
  final bool isGenderBased;
  const faqpage({super.key, required this.title, required this.isGenderBased});

  @override
  State<faqpage> createState() => _faqpageState();
}

class _faqpageState extends State<faqpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.title} FAQ's",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
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
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.search_sharp),
                  focusColor: Color(0xff88704e),
                ),
                cursorColor: Color(0xff88704e),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  splashColor: Colors.white.withOpacity(0.1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => qna(
                                  title: widget.title,
                                  isGenderBased: widget.isGenderBased,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.title + " Query",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Color(0xff88704e)),
                            child: Icon(
                              Icons.play_arrow_sharp,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  splashColor: Colors.white.withOpacity(0.1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => qna(
                                  title: widget.title,
                                  isGenderBased: widget.isGenderBased,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.title + " Query",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Color(0xff88704e)),
                            child: Icon(
                              Icons.play_arrow_sharp,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}
