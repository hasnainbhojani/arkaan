import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hajj/config/api_config.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:hajj/pages/indexSection.dart';
import 'package:hajj/pages/sections.dart';
import 'package:hajj/services/data_service.dart';
import 'package:hajj/services/language_service.dart';
import 'package:provider/provider.dart';

class Ziyarat extends StatefulWidget {
  final HajjDataList category5Data;
  final HajjDataList category6Data;
  final List<Map<String, String>> endpoints;

  const Ziyarat({
    super.key,
    required this.category5Data,
    required this.category6Data,
    required this.endpoints,
  });

  @override
  State<Ziyarat> createState() => _ZiyaratState();
}

class _ZiyaratState extends State<Ziyarat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Modified cards section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  _buildCategoryCard(
                    context,
                    widget.category5Data,
                    "assets/image/ziyarat.jpg",
                    "Ziyarat",
                    0,
                  ),
                  SizedBox(height: 12),
                  _buildCategoryCard(
                    context,
                    widget.category6Data,
                    "assets/image/dua.jpg",
                    "Dua",
                    2,
                  ),
                ],
              ),
            ),
          ),

          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: SingleChildScrollView(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           _buildCategoryCard(
          //             context,
          //             widget.category5Data,
          //             "assets/image/ziyarat.jpg",
          //             "Ziyarat",
          //             0,
          //           ),
          //           _buildCategoryCard(
          //             context,
          //             widget.category6Data,
          //             "assets/image/dua.jpg",
          //             "Dua",
          //             2,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    HajjDataList data,
    String imagePath,
    String title,
    int initialIndex,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZiyaratDuaScreen(
              hajjData: data,
              initialIndex: initialIndex,
              title: title,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.star_border_outlined, size: 18),
                  onPressed: () {},
                ),
              ],
            ),
            const Divider(color: Colors.black, height: 1),
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}

class ZiyaratDuaScreen extends StatefulWidget {
  final HajjDataList hajjData;
  var title;

  final int initialIndex;
  ZiyaratDuaScreen(
      {super.key,
      required this.hajjData,
      required this.title,
      this.initialIndex = 0});

  @override
  State<ZiyaratDuaScreen> createState() => _ZiyaratDuaScreenState();
}

class _ZiyaratDuaScreenState extends State<ZiyaratDuaScreen> {
  late int _selectedCategoryIndex;
  final _idController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Sticker
        Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            padding: EdgeInsets.all(2),
            child: Image.asset("assets/image/sticker.png")),

        // Tawaf Dua & Saee Dua Buttons
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //       InkWell(
        //         onTap: () {
        //           _hajjData.then((data) {
        //             final category6Data = data['category6'];
        //             if (category6Data != null) {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => Dua(
        //                     name: "Tawaf Dua",
        //                     id: 0,
        //                     hajjData: category6Data, // Pass category6 data
        //                   ),
        //                 ),
        //               );
        //             }
        //           });
        //         },
        //       child: Row(
        //         children: [
        //           Container(
        //               child: Image.asset(
        //             "assets/image/kaaba1.png",
        //             fit: BoxFit.cover,
        //             height: 26,
        //             width: 26,
        //             alignment: Alignment.topCenter,
        //           )),
        //           SizedBox(
        //             width: 10,
        //           ),
        //           Text(
        //             "Tawaf Dua",
        //             style: TextStyle(color: Colors.white, fontSize: 12),
        //           )
        //         ],
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Row(
        //         children: [
        //           Container(
        //               child: Image.asset(
        //             "assets/image/mountain1.png",
        //             fit: BoxFit.cover,
        //             height: 26,
        //             width: 26,
        //           )),
        //           SizedBox(
        //             width: 10,
        //           ),
        //           Text(
        //             "Sa`ee Dua",
        //             style: TextStyle(color: Colors.white, fontSize: 12),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content Section
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IndexSection(
                    category:
                        widget.hajjData.categories[_selectedCategoryIndex],
                    idStream: _idController.stream,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  // Update the _refreshData method in _ZiyaratDuaScreenState
  void _refreshData(BuildContext context) {
    // Get current language endpoints
    final languageService =
        Provider.of<LanguageService>(context, listen: false);
    final endpoints =
        ApiConfig.endpoints[languageService.currentLanguage] ?? [];

    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Refreshing Data..."),
          ],
        ),
      ),
    );

    DataService.fetchAllData(endpoints).then((newData) {
      // Add endpoints parameter
      Navigator.pop(context);
      setState(() {
        _selectedCategoryIndex = 0;
      });
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to refresh: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  // void _refreshData(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => const AlertDialog(
  //       content: Row(
  //         children: [
  //           CircularProgressIndicator(),
  //           SizedBox(width: 20),
  //           Text("Refreshing Data..."),
  //         ],
  //       ),
  //     ),
  //   );

  //   DataService.fetchAllData().then((newData) {
  //     Navigator.pop(context); // Close loading dialog
  //     setState(() {
  //       _selectedCategoryIndex = 0;
  //     });
  //   }).catchError((error) {
  //     Navigator.pop(context); // Close loading dialog
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Error'),
  //         content: Text('Failed to refresh: $error'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  Widget _buildCategoryCard(
    BuildContext context,
    HajjDataList data,
    String imagePath,
    String title,
  ) {
    final hasData = data.categories.isNotEmpty;

    return InkWell(
      onTap: hasData
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sections(
                    hajjData: data,
                    endpoints: ApiConfig.endpoints[
                        Provider.of<LanguageService>(context, listen: false)
                            .currentLanguage]!,
                  ),
                ),
              );
            }
          : null, // Disable tap if no data
      child: Opacity(
        opacity: hasData ? 1.0 : 0.5, // Visual indication for disabled state
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: hasData ? Colors.black : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star_border_outlined,
                      size: 18,
                      color: hasData ? Colors.black : Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const Divider(color: Colors.black, height: 1),
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              if (!hasData)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "No data available",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
