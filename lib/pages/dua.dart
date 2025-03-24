import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dua extends StatefulWidget {
  var id;
  var name;
  Dua({super.key, required this.id, required this.name});

  @override
  State<Dua> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Dua> {
  int currentTileIndex = 1;
  int itemCount = 7;
  late SharedPreferences prefs;
  var textsize;
  List _itemsJson = [];
  List _itemsJsonn = [];
  List fetchedData = [];
  bool isLoading = true;

  Future<void> fetchJson() async {
    setState(() {
      isLoading = true; // Show loader before fetching
    });

    final url = Uri.parse(
        "http://famtechglobal.com/arkan/public/get_content/${widget.id}");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _itemsJson = data["data"] ?? [];
        var newId = _itemsJson[currentTileIndex - 1]["id"];
        print(newId);
        final newResponse = await http.get(Uri.parse(
            "http://famtechglobal.com/arkan/public/get_content_details/${newId}"));
        if (newResponse.statusCode == 200) {
          final newData = json.decode(newResponse.body);
          setState(() {
            _itemsJsonn = [newData["data"]];
            fetchedData = [newData["content_data"]];
            isLoading = false;
          });
        } else {
          throw Exception("Failed!!");
        }
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    if (_itemsJsonn.isEmpty) {
      Timer(Duration(seconds: 5), () {
        fetchJson(); // Retry fetching data
      });
    }
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    textsize = prefs.getDouble('textsize') ?? 22.0;
    setState(() {});
  }

  String styleHtmlText(String htmlText) {
    // Apply styles dynamically
    return htmlText.replaceAllMapped(RegExp(r'[\u0600-\u06FF]+'), (match) {
      // Arabic Text
      return '<span style="font-family: Quranicfont, sans-serif; font-size:${textsize + 20}; line-height: 1.9; ">${match.group(0)}</span>';
    }).replaceAllMapped(RegExp(r'[\u0A80-\u0AFF]+'), (match) {
      // Gujarati Text
      return '<span style="font-family: MuktaVaani, font-size:${textsize}, sans-serif;">${match.group(0)}</span>';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
    fetchJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.name}"),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (textsize < 34.0) {
                      setState(() {
                        textsize += 2.0;
                        prefs.setDouble('textsize', textsize);
                      });
                    }
                  },
                  child: Icon(Icons.text_increase_sharp, size: 22),
                ),
                SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    if (textsize > 22.0) {
                      setState(() {
                        textsize -= 2.0;
                        prefs.setDouble('textsize', textsize);
                      });
                    }
                  },
                  child: Icon(Icons.text_decrease_sharp, size: 22),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(), // Show loading spinner
                  )
                : ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        padding: EdgeInsets.all(2),
                        child: Image.asset("assets/image/sticker.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(color: Color(0xFF444444)),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: _itemsJsonn.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: HtmlWidget(
                                        styleHtmlText(
                                            _itemsJsonn[0]["content"]),
                                        textStyle: TextStyle(
                                            fontSize: textsize,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : Center(child: Text("No Data Found!!")),
                        ),
                      ),
                    ],
                  ),
          ),
          Expanded(
            flex: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double itemHeight = constraints.maxHeight /
                    itemCount; // Dynamic height per item
                double circleWidth = constraints.maxWidth *
                    0.9; // Ensure perfect half-circle width

                return Center(
                  child: ListView.builder(
                    itemCount: itemCount,
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling
                    itemBuilder: (context, index) {
                      bool isActive = index + 1 == currentTileIndex;

                      return SizedBox(
                        height: itemHeight, // Adjust height dynamically
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                // ✅ Remaining space (Now on the Left)
                                Expanded(
                                  child: Container(
                                    height: itemHeight,
                                    color: Colors.black,
                                  ),
                                ),
                                // ✅ Divider Line
                                Container(
                                    width: 5,
                                    height: itemHeight,
                                    color: Colors.black),
                                // ✅ Right side design (Perfect Half-Circle)
                                Container(
                                  width:
                                      circleWidth, // Ensure perfect half-circle
                                  height: itemHeight,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? Colors.amber
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(itemHeight /
                                          2), // ✅ Now curved on left
                                      bottomLeft: Radius.circular(itemHeight /
                                          2), // ✅ Now curved on left
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            // ✅ Tap Area
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: index == currentTileIndex
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Text("Alert"),
                                              content: Text(
                                                  "Do you want to go to the next step?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (currentTileIndex <
                                                            itemCount) {
                                                          currentTileIndex++;
                                                          _itemsJsonn = [];
                                                          fetchJson();
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Text("Yes")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("No"))
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//   ListView.builder(
                //   itemCount: 7, // Only 7 ListTiles
                //   itemBuilder: (context, index) {
                //     return Container(
                //       decoration: BoxDecoration(
                //         color: index == currentTileIndex - 1
                //             ? Colors.blueAccent // Color current tile
                //             : Colors.transparent,
                //       ), // No color for others
                //       child: ListTile(
                //         leading: CircleAvatar(
                //           child: Text(
                //             "${index + 1}",
                //             style: TextStyle(color: Colors.white),
                //           ),
                //           backgroundColor: Colors.transparent,
                //         ),

                //         enabled: index ==
                //             currentTileIndex, // Only current tile enabled
                //         onTap: index == currentTileIndex
                //             ? () {
                //                 showDialog(
                //                   context: context,
                //                   builder: (context) {
                //                     return AlertDialog(
                //                       backgroundColor: Colors.white,
                //                       title: Text("Alert"),
                //                       content: Text(
                //                           "You really want to go to next dua?"),
                //                       actions: [
                //                         TextButton(
                //                             onPressed: () {
                //                               setState(() {
                //                                 currentTileIndex++;
                //                                 _itemsJsonn = [];
                //                                 fetchJson();
                //                                 Navigator.of(context).pop();
                //                               });
                //                             },
                //                             child: Text("Yes")),
                //                         TextButton(
                //                             onPressed: () {
                //                               setState(() {
                //                                 Navigator.of(context).pop();
                //                               });
                //                             },
                //                             child: Text("No"))
                //                       ],
                //                     );
                //                   },
                //                 );
                //               }
                //             : null,
                //       ),
                //     );
                //   },
                // ),