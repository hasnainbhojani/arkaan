import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

PrayerTimes prayerTimesFromJson(String str) =>
    PrayerTimes.fromJson(json.decode(str));

class PrayerTimes {
  PrayerTimes({
    required this.data,
  });

  final Data data;

  factory PrayerTimes.fromJson(Map<String, dynamic> json) => PrayerTimes(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.timings,
  });

  final Timings timings;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        timings: Timings.fromJson(json["timings"]),
      );
}

class Timings {
  Timings({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
        fajr: json["Fajr"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
      );
}

class ApiService {
  static Future<PrayerTimes> fetchMakkahPrayerTimes() async {
    final Uri url = Uri.parse(
        'http://api.aladhan.com/v1/timingsByCity?city=Mecca&country=Saudi%20Arabia&method=0' // Method 0 = Shia Leva Institute Qum
        );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return PrayerTimes.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  static Future<PrayerTimes> fetchMadinahPrayerTimes() async {
    final Uri url = Uri.parse(
        'http://api.aladhan.com/v1/timingsByCity?city=Medina&country=Saudi%20Arabia&method=0' // Method 0 = Shia Leva Institute Qum
        );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return PrayerTimes.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}

// prayer_times_screen.dart

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late Future<PrayerTimes> _makkahTimes;
  late Future<PrayerTimes> _madinahTimes;

  @override
  void initState() {
    super.initState();
    _makkahTimes = ApiService.fetchMakkahPrayerTimes();
    _madinahTimes = ApiService.fetchMadinahPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Namaz Timings')),
        body: Column(
          children: [
            FutureBuilder<PrayerTimes>(
              future: ApiService.fetchMakkahPrayerTimes(),
              builder: (context, snapshot) {
                // Use default values while loading or on error
                final times = snapshot.hasData
                    ? snapshot.data!.data.timings
                    : Timings(
                        fajr: "",
                        dhuhr: "",
                        asr: "",
                        maghrib: "",
                        isha: "",
                      );

                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                        Stack(
                          children: [
                            Container(
                              height: 78,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/image/timedesign.png")),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Makkah Timings",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTimeColumn("Fajr",
                                  CupertinoIcons.cloud_sun_fill, times.fajr),
                              _buildTimeColumn("Zuhr",
                                  CupertinoIcons.sun_max_fill, times.dhuhr),
                              _buildTimeColumn(
                                  "Asr", CupertinoIcons.sunset, times.asr),
                              _buildTimeColumn(
                                  "Maghrib",
                                  CupertinoIcons.cloud_moon_fill,
                                  times.maghrib),
                              _buildTimeColumn("Isha",
                                  CupertinoIcons.moon_stars_fill, times.isha),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 25,
            ),
            FutureBuilder<PrayerTimes>(
              future: ApiService.fetchMadinahPrayerTimes(),
              builder: (context, snapshot) {
                // Use default values while loading or on error
                final times = snapshot.hasData
                    ? snapshot.data!.data.timings
                    : Timings(
                        fajr: "",
                        dhuhr: "",
                        asr: "",
                        maghrib: "",
                        isha: "",
                      );

                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                        Stack(
                          children: [
                            Container(
                              height: 78,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/image/timedesign.png")),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Madinah Timings",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTimeColumn("Fajr",
                                  CupertinoIcons.cloud_sun_fill, times.fajr),
                              _buildTimeColumn("Zuhr",
                                  CupertinoIcons.sun_max_fill, times.dhuhr),
                              _buildTimeColumn(
                                  "Asr", CupertinoIcons.sunset, times.asr),
                              _buildTimeColumn(
                                  "Maghrib",
                                  CupertinoIcons.cloud_moon_fill,
                                  times.maghrib),
                              _buildTimeColumn("Isha",
                                  CupertinoIcons.moon_stars_fill, times.isha),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Center(
                  child: Text(
                "These timings are based on Shia Ithna Ashari, Leva Research Institute, Qum",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              )),
            )
          ],
        ));
  }

// Reusable column builder
  Widget _buildTimeColumn(String title, IconData icon, String time) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 11, color: Colors.white)),
        Icon(icon, color: Colors.white.withOpacity(0.5)),
        Text(time, style: TextStyle(fontSize: 11, color: Colors.white)),
      ],
    );
  }
}
