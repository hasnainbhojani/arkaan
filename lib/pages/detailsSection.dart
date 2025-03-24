import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class detailSection extends StatefulWidget {
  var id;

  detailSection({super.key, required this.id});

  @override
  State<detailSection> createState() => _detailSectionState();
}

class _detailSectionState extends State<detailSection> {
  late SharedPreferences prefs;
  List _itemsJson = [];
  List _itemsJsonn = [];
  var textsize;
  bool isLoading = true;
  List<bool> _isExpanded = [];

  Future<void> fetchJson() async {
    setState(() {
      isLoading = true;
    });

    var link =
        "http://famtechglobal.com/arkan/public/get_content_details/${widget.id}";
    try {
      final response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (data["data"] is List) {
            _itemsJson = data["data"];
            _itemsJsonn = data["content_data"];
          } else if (data["data"] is Map) {
            _itemsJson = [data["data"]];
            _itemsJsonn = [data["content_data"]];
          }

          // Initialize _isExpanded with the correct length
          if (_itemsJsonn.isNotEmpty && _itemsJsonn[0] is List) {
            _isExpanded = List.filled(_itemsJsonn[0].length, false);
          } else {
            _isExpanded = [];
          }

          isLoading = false;
        });
      } else {
        print("Error fetching data");
      }
    } catch (e) {
      print("Exception: $e");
    }

    if (_itemsJsonn.isEmpty) {
      Timer(Duration(seconds: 5), () {
        fetchJson();
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
    super.initState();
    initPrefs();
    fetchJson();
  }

// Initialize _isExpanded list when data is fetched
  void initializeExpansionState() {
    setState(() {
      _isExpanded = List.generate(_itemsJsonn[0].length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/image/arkan.png", width: 100),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: EdgeInsets.all(2),
                  child: Image.asset("assets/image/sticker.png"),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    child: _itemsJson.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: GradientText(
                                  _itemsJson[0]["product_name"].toString(),
                                  style: TextStyle(
                                    fontSize: textsize,
                                  ),
                                  colors: [
                                    Color(0xFFFFD700), // Gold
                                    Color(0xFFFFE135), // Lighter Gold
                                    Color(0xFFFFC107), // Darker Gold/Amber
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "http://famtechglobal.com/arkan/public/images/${_itemsJson[0]["image"]}",
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Text("Image not available"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: HtmlWidget(
                                  styleHtmlText(_itemsJson[0]["content"] ?? ""),
                                  textStyle: TextStyle(fontSize: textsize),
                                ),
                              ),
                              _itemsJsonn.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: _itemsJsonn[0].length,
                                      itemBuilder: (context, index) {
                                        var item = _itemsJsonn[0][index];
                                        return ExpansionTile(
                                          tilePadding: EdgeInsets.zero,
                                          iconColor: Colors.white,
                                          leading: Icon(
                                            _isExpanded[index]
                                                ? Icons
                                                    .indeterminate_check_box_outlined
                                                : Icons.add_box_outlined,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                            item['sub_title'] ?? 'Untitled',
                                            style: TextStyle(
                                              fontSize: textsize,
                                              color: Colors.black,
                                              fontWeight: _isExpanded[index]
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                          initiallyExpanded: _isExpanded[index],
                                          onExpansionChanged: (expanded) {
                                            setState(() {
                                              _isExpanded[index] = expanded;
                                            });
                                          },
                                          children: [
                                            if (item['sub_image'] != null)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            "http://famtechglobal.com/arkan/public/images/${item["sub_image"]}",
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Text("")),
                                                  ),
                                                ),
                                              ),
                                            if (item['description'] != null)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: HtmlWidget(
                                                  styleHtmlText(
                                                      item["description"] ??
                                                          ""),
                                                  textStyle: TextStyle(
                                                      fontSize: textsize - 2,
                                                      color: Colors.black),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                      "No Data Found!",
                                      style: TextStyle(color: Colors.white),
                                    )),
                            ],
                          )
                        : Center(child: Text("No Data Found!!")),
                  ),
                ),
              ],
            ),
    );
  }
}
