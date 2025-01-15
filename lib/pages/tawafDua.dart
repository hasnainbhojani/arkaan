import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tawafdua extends StatefulWidget {
  const Tawafdua({super.key});

  @override
  State<Tawafdua> createState() => _TawafduaState();
}

class _TawafduaState extends State<Tawafdua> {
  NavigationRailLabelType labelType = NavigationRailLabelType.none;
  late SharedPreferences prefs;
  var textsize;
  int _selectedIndex = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    textsize = prefs.getDouble('textsize');
    if (textsize == null) {
      textsize = 20.0;
    }
    print(textsize);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(
                "assets/image/arkan.png",
              ),
              width: 100,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (textsize == 20.0 ||
                        textsize == 22.0 ||
                        textsize == 24.0 ||
                        textsize == 26.0 ||
                        textsize == 28.0) {
                      textsize = textsize + 2.0;
                      prefs.setDouble('textsize', textsize);
                      print(textsize);
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.text_increase_sharp,
                    size: 22,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    if (textsize == 30.0 ||
                        textsize == 28.0 ||
                        textsize == 26.0 ||
                        textsize == 24.0 ||
                        textsize == 22.0) {
                      textsize = textsize - 2.0;
                      prefs.setDouble('textsize', textsize);
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.text_decrease_sharp,
                    size: 22,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.all(2),
              child: Image.asset("assets/image/sticker.png")),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child: Text("0"),
                )),
                NavigationRail(
                  useIndicator: true,
                  indicatorColor: Colors.transparent,
                  groupAlignment: -0.5,
                  selectedIconTheme:
                      CupertinoIconThemeData(color: Colors.amber, size: 40),
                  unselectedIconTheme:
                      CupertinoIconThemeData(size: 40, color: Colors.white),
                  destinations: [
                    NavigationRailDestination(
                      icon: ImageIcon(
                        AssetImage("assets/image/ut_ehram.png"),
                      ),
                      label: Text(""),
                    ),
                    NavigationRailDestination(
                      icon: ImageIcon(
                        AssetImage("assets/image/ut_tawaf.png"),
                      ),
                      label: Text(""),
                    ),
                    NavigationRailDestination(
                      icon: ImageIcon(
                        AssetImage("assets/image/ut_namaz.png"),
                      ),
                      label: Text(""),
                    ),
                    NavigationRailDestination(
                      icon: ImageIcon(
                        AssetImage("assets/image/ut_saee.png"),
                      ),
                      label: Text(""),
                    ),
                    NavigationRailDestination(
                      icon: ImageIcon(
                        AssetImage("assets/image/ut_taksir.png"),
                      ),
                      label: Text(""),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: labelType,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
