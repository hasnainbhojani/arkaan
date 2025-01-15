/*Dua Page when you click on specific dua*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late SharedPreferences prefs;
  var textsize; // Determines size of the text
  var text =
      "એક ગરીબ ખેડૂત હતો જેના પાંચ બાળકો હતા. તે ખૂબ જ મહેનતુ હતો, પરંતુ તેનું કમાવાનું ઓછું હતું. એક દિવસ, તે જંગલમાં લાકડા કાપવા ગયો. ત્યાં તેને એક ચમત્કારી દીવો મળ્યો. તેણે દીવો ઘરે લઈ ગયો અને જ્યારે તેણે તેને કર્યો, ત્યારે તેમાંથી એક જિનિય પ્રગટ થયો. જિનિયે ખેડૂતને ત્રણ ઈચ્છાઓ પૂરી કરવાની તક આપી.\n لمّا كان الاعتراف بالكرامة المتأصلة في جميع";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    // Saves and loads the font size according to the user preference
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
            // Heading image
            Image(
              image: AssetImage(
                "assets/image/arkan.png",
              ),
              width: 100,
            ),
            // Buttons to increase and decrease the text size
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sticker
            Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                padding: EdgeInsets.all(2),
                child: Image.asset("assets/image/sticker.png")),
            // Dua Text
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Text(
                    "$text",
                    style: GoogleFonts.rasa(fontSize: textsize),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
