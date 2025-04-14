import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:hajj/services/image_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailSection extends StatefulWidget {
  final HajjItem item;
  final int? subItemIndex;
  const DetailSection({super.key, required this.item, this.subItemIndex});

  @override
  State<DetailSection> createState() => _DetailSectionState();
}

class _DetailSectionState extends State<DetailSection> {
  late List<bool> _isExpanded;
  var textsize;
  late SharedPreferences prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    textsize = prefs.getDouble('textsize') ?? 20.0;
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
    _isExpanded = List<bool>.filled(widget.item.subItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/image/arkan.png",
              width: 75,
              height: 16,
            ),
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
      body: ListView(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GradientText(
                      widget.item.title,
                      style: TextStyle(fontSize: textsize),
                      colors: [
                        Color(0xFFFFD700), // Gold
                        Color(0xFFFFE135), // Lighter Gold
                        Color(0xFFFFC107), // Darker Gold/Amber
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ImageCachee.cachedImage(
                    widget.item.image,
                    height: 200,
                    //fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget(
                      styleHtmlText(widget.item.content),
                      textStyle: TextStyle(fontSize: textsize),
                    ),
                  ),
                  _buildSubItems(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.item.subItems.length,
      itemBuilder: (context, index) {
        final subItem = widget.item.subItems[index];
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          iconColor: Colors.white,
          leading: Icon(
              _isExpanded[index]
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.add_box_outlined,
              color: Colors.black),
          title: Text(
            subItem.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: textsize,
              fontWeight:
                  _isExpanded[index] ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          initiallyExpanded: _isExpanded[index],
          onExpansionChanged: (expanded) {
            setState(() => _isExpanded[index] = expanded);
          },
          children: [
            if (subItem.image != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ImageCachee.cachedImage(
                  subItem.image!,
                  height: 150,
                  //fit: BoxFit.cover,
                ),
              ),
            if (subItem.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  styleHtmlText(subItem.description),
                  textStyle: TextStyle(fontSize: textsize),
                ),
              ),
          ],
        );
      },
    );
  }
}
