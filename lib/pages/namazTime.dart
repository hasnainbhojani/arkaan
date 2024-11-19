import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Namaztime extends StatefulWidget {
  const Namaztime({super.key});

  @override
  State<Namaztime> createState() => _NamaztimeState();
}

class _NamaztimeState extends State<Namaztime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Namaz Timing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: Color(0xff88704e),
                width: 2,
              )),
          child: Column(
            children: [
              // Location for Namaz Timing
              Stack(
                children: [
                  Container(
                    height: 78,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/image/timedesign.png")),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fajr-Mecca",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text("1hr 24 min",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Timing for Namaz
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Fajr",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.cloud_sun_fill,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        Text(
                          "04:30",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Zuhr",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.sun_max_fill,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        Text(
                          "12:45",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Asr",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.sunset,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        Text(
                          "14.50",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Maghrib",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.cloud_moon_fill,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        Text(
                          "17:26",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Isha",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.moon_stars_fill,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        Text(
                          "18:36",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
