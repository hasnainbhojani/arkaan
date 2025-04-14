import 'package:flutter/material.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dua extends StatefulWidget {
  final HajjDataList? hajjData;
  final String name;
  var id;
  Dua(
      {super.key,
      required this.name,
      required this.hajjData,
      required this.id});

  @override
  State<Dua> createState() => _DuaState();
}

class _DuaState extends State<Dua> {
  int currentTileIndex = 1;
  int currentDataIndex = 0;
  var textsize;
  List<dynamic> _itemsJsonn = [];
  late ScrollController _scrollController;
  int itemCount = 7;

  late SharedPreferences prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    textsize = prefs.getDouble('textsize') ?? 22.0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    initPrefs();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose controller
    super.dispose();
  }

  void _loadData() {
    if (widget.hajjData != null && widget.hajjData!.categories.isNotEmpty) {
      final category = widget.hajjData!.categories[widget.id];
      if (category.items.isNotEmpty) {
        _itemsJsonn = category.items;
      }
    }
  }

  void _handleNextStep() {
    if (currentTileIndex < itemCount) {
      currentTileIndex++;
      currentDataIndex++;
      _scrollController.jumpTo(0); // Reset scroll position
    }
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
        children: [
          Expanded(flex: 6, child: _buildDua(context)),
          Expanded(
            flex: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double itemHeight = constraints.maxHeight / itemCount;
                double circleWidth = constraints.maxWidth * 0.9;

                return Center(
                  child: ListView.builder(
                    itemCount: itemCount,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      bool isActive = index + 1 == currentTileIndex;

                      return SizedBox(
                        height: itemHeight,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: itemHeight,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                    width: 5,
                                    height: itemHeight,
                                    color: Colors.black),
                                Container(
                                  width: circleWidth,
                                  height: itemHeight,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? Colors.amber
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(itemHeight / 2),
                                      bottomLeft:
                                          Radius.circular(itemHeight / 2),
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
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: index + 1 == currentTileIndex + 1
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text("Alert"),
                                            content: Text(
                                                "Do you want to go to the next step?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    _handleNextStep();
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text("No"))
                                            ],
                                          ),
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

  Widget _buildDua(BuildContext context) {
    return ListView(
      controller: _scrollController,
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
                          styleHtmlText(_itemsJsonn[currentDataIndex].content),
                          textStyle: TextStyle(
                              fontSize: textsize, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : Center(child: Text("No Data Found!!")),
          ),
        ),
      ],
    );
  }
}
