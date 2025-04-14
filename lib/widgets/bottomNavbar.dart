// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hajj/config/api_config.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:hajj/pages/aboutUs.dart';
import 'package:hajj/pages/credits.dart';
import 'package:hajj/pages/dua.dart';
import 'package:hajj/pages/favourites.dart';
import 'package:hajj/pages/namazTime.dart';
import 'package:hajj/pages/policy.dart';
import 'package:hajj/pages/queries.dart';
import 'package:hajj/pages/search.dart';
import 'package:hajj/pages/sections.dart';
import 'package:hajj/pages/ziyarat.dart';
import 'package:hajj/services/data_service.dart';

class navMenu extends StatefulWidget {
  const navMenu({super.key});

  @override
  State<navMenu> createState() => _navMenuState();
}

class _navMenuState extends State<navMenu> {
  int _currentIndex = 0;
  late Future<Map<String, HajjDataList>> _hajjData;

  @override
  void initState() {
    super.initState();
    _hajjData = DataService.fetchAllData();
  }

  final List<String> _navMapping = [
    'category1',
    'category2',
    'category3',
    'category4',
    'category5'
  ];

  void _loadData() {
    setState(() {
      _hajjData = DataService.fetchAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Heading Image
            Image(
              image: AssetImage(
                "assets/image/arkan.png",
              ),
              width: 75,
              height: 16,
            ),
            Row(
              children: [
                // Namaztime feature Icon
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrayerTimesScreen()));
                  },
                  child: Icon(
                    CupertinoIcons.time,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                // Search Feature Icon
                InkWell(
                  onTap: () {
                    // Wait for the data to load before navigating
                    _hajjData.then((data) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(allData: data),
                        ),
                      );
                    }).catchError((error) {
                      // Show error if data loading fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error loading data: $error')),
                      );
                    });
                  },
                  child: Icon(CupertinoIcons.search, size: 20),
                )
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/logo.png",
                    height: 50,
                    width: 47,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Flexible(
                    child: Text(
                      "The Comprehensive Guide to Hajj Rituals",
                      style: TextStyle(color: Colors.amber),
                    ),
                  )
                ],
              ),
            ),
            Image.asset("assets/image/sticker.png"),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.refresh_outlined),
              title: Text("Refresh"),
              onTap: () {
                Navigator.pop(context);
                _loadData();
              },
            ),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.access_time_outlined),
              title: Text("Prayer Times"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrayerTimesScreen()));
              },
            ),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favourites"),
              onTap: () {
                Navigator.pop(context);
                _navigateToFavorites(context);
              },
            ),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("Ask your Question"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Queries()));
              },
            ),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About Us"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text("Privacy Policy"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Policy()));
              },
            ),
            Divider(
              thickness: 0.1,
            ),
            ListTile(
              leading: Icon(Icons.note_rounded),
              title: Text("Credits"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Credits()));
              },
            ),
            Divider(
              thickness: 0.1,
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text("Close App"),
                      content: Text("Do you really want to close app?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("No")),
                        TextButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: Text("Yes")),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        iconSize: 24, // Adjust if needed
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
            color: Colors
                .amber), // No need to use CupertinoIconThemeData unless specific
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize:
                  MainAxisSize.min, // Make sure to keep only min space
              children: [
                ImageIcon(
                  AssetImage("assets/image/umrahtamattubtmnvb.png"),
                  size: 20, // Adjust icon size if needed
                ),
                SizedBox(height: 2), // Reduced spacing
                Text(
                  "Umrah Tamattu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9), // Adjust font size
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/hajjtamattubtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Hajj Tamattu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/umrahmufredabtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Umrah Mufreda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/meccamadinabtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Mecca Madinah",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/image/ziyaratbtmnvb.png"),
                  size: 20,
                ),
                SizedBox(height: 2),
                Text(
                  "Ziyarat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            label: '',
          ),
        ],
      ),

      body: Column(
        children: [
          // Sticker
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.all(2),
              child: Image.asset("assets/image/sticker.png")),

          // Tawaf Dua & Saee Dua Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _hajjData.then((data) {
                    final category6Data = data['category6'];
                    if (category6Data != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dua(
                            name: "Tawaf Dua",
                            id: 0,
                            hajjData: category6Data, // Pass category6 data
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Row(
                  children: [
                    Container(
                        child: Image.asset(
                      "assets/image/kaaba1.png",
                      fit: BoxFit.cover,
                      height: 26,
                      width: 26,
                      alignment: Alignment.topCenter,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Tawaf Dua",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _hajjData.then((data) {
                    final category6Data = data['category6'];
                    if (category6Data != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dua(
                            name: "Sa'ee Dua",
                            id: 1,
                            hajjData: category6Data, // Pass category6 data
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Row(
                  children: [
                    Container(
                        child: Image.asset(
                      "assets/image/mountain1.png",
                      fit: BoxFit.cover,
                      height: 26,
                      width: 26,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sa`ee Dua",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: FutureBuilder<Map<String, HajjDataList>>(
              future: _hajjData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoading();
                }
                if (snapshot.hasError) {
                  return _buildError(snapshot.error!);
                }
                if (snapshot.hasData) {
                  return _buildMainContent(snapshot.data!);
                }
                return _buildEmpty();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToFavorites(BuildContext context) {
    _hajjData.then((data) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritesPage(allData: data),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading favorites: $error')),
      );
    });
  }

  Widget _buildMainContent(Map<String, HajjDataList> allData) {
    if (_currentIndex == 4) {
      // 5th tab
      final category5Data =
          allData['category5'] ?? HajjDataList(categories: []);
      final category6Data =
          allData['category6'] ?? HajjDataList(categories: []);

      return Ziyarat(
        key: ValueKey('ziyarat_${DateTime.now()}'),
        category5Data: category5Data,
        category6Data: category6Data,
      );
    }

    final categoryKey = _navMapping[_currentIndex];
    final categoryData = allData[categoryKey];

    return categoryData != null
        ? Sections(
            key: ValueKey(_currentIndex),
            hajjData: categoryData,
          )
        : _buildError('Category data not found');
  }

  Widget _buildLoading() => const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.orange,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Loading Data and Assets..",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            "This may take a while.",
            style: TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ));

  Widget _buildError(Object error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 40),
            Text(
              'Something went wrong. Please try again',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () =>
                  setState(() => _hajjData = DataService.fetchAllData()),
              child: const Text('Retry'),
            ),
          ],
        ),
      );

  Widget _buildEmpty() => const Center(child: Text('No data available'));
}
