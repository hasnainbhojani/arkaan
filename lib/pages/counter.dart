// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class counter extends StatefulWidget {
  const counter({super.key});

  @override
  State<counter> createState() => _counterState();
}

class _counterState extends State<counter> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Counter",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelColor: Colors.white,
                            labelColor: Colors.black,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: Color(0xff88704e),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            controller: tabController,
                            tabs: [
                              Tab(
                                text: 'Tawaf',
                              ),
                              Tab(
                                text: 'Safah Marwa',
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  tawafSafa(image: "assets/image/tawaf 1.png"),
                  tawafSafa(image: "assets/image/safamarva.png")
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class tawafSafa extends StatefulWidget {
  final String image;
  const tawafSafa({super.key, required this.image});

  @override
  State<tawafSafa> createState() => _tawafSafaState();
}

class _tawafSafaState extends State<tawafSafa> {
  int counting = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Image.asset(
          widget.image,
          width: 244,
          height: 244,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                side: BorderSide(color: Color(0xff88704e), width: 2)),
            onPressed: () {
              counting = 0;
              setState(() {});
            },
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white),
            )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (counting > 0) {
                    counting--;
                    setState(() {});
                  }
                },
                child: Container(
                  height: 51,
                  width: 51,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Color(0xff88704e),
                        width: 2,
                      )),
                  child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 101,
                width: 101,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff88704e),
                      width: 2,
                    )),
                child: Center(
                  child: Text(
                    counting.toString(),
                    style: TextStyle(fontSize: 64),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  if (counting < 7) {
                    counting++;
                    setState(() {});
                  }
                },
                child: Container(
                  height: 51,
                  width: 51,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Color(0xff88704e),
                        width: 2,
                      )),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
/*
DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.all(20),
              unselectedLabelColor: Colors.white,
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Creates border
                color: Color(0xff88704e),
              ),
              tabs: [
                Tab(
                  text: 'Tawaf',
                ),
                Tab(
                  text: 'Safah Marwah',
                )
              ],
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
          ],
        ),
      ),
    );
  }
}
*/