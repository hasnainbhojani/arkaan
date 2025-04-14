import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  var desc =
      '''હજ એક અઝીમ ઇબાદત છે અને જો હાજી હજ ની તૈયારી નો કરે અને કોઈ ભૂલ પડી જાય તો હજ બાતિલ થઈ જાય અને આજ ના સમય માં તૈયારી કરવા માટે સમય કાઢવા નો હાજી માટે બહુ કઠીન કામ છે. આ માટે ભાવનગર હજ ખિદમત કમિટી( ખાસ તો ઇન્ડિયા ની હજ કમિટી માંથી જવા વાળા માટે)  ૨૦૦૭ થી હાજીઓ ને હજ વિશે જાણકારી આપે છે અને તેમનો હજ સહી થાય તેમાં મદદરૂપ થાય છે. હું પર્સનલી ૨૦૧૭ માં હજ કર્યા પછી તેમાં જોડાણો. હાજીઓ ને વોટ્સએપ ગ્રુપ દ્વારા માહિતી આપવા છતાં  ઉમરાહે તમત્તો અને હજજે તમત્તો ના દિવસો માં તકલીફો પડતી હોવા થી હું એ નિર્ણય પર આવ્યો કે એક એવી એપ બનાવીએ જે જે તે સમયે હાજી ને તેને પડતી તકલીફ માં તરતજ જવાબ મળી રહે.
      
      اَللّٰهُمَّـ تَقَبَّلۡ مِنِّی
     અય અલ્લાહ! આ કોશિશ ને મારી તરફ થી કબૂલ ફરમાં.
     
     Contact Information:
     Email: hajijinfo@gmail.com
     Mukhtarali Vazirali Badami
     ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/background.jpg"),
                fit: BoxFit.fitHeight)),
        child: Container(
          margin: EdgeInsets.all(25),
          color: Colors.black.withOpacity(0.7),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    desc,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
