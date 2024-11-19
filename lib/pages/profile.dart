// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hajj/controller/logincontroller.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 40),
                  child: Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          ListTile(
                            iconColor: Color(0xff88704e),
                            minTileHeight: 75,
                            leading: Icon(Icons.person),
                            title: Text("My Profile"),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                          ListTile(
                            iconColor: Color(0xff88704e),
                            minTileHeight: 75,
                            leading: FaIcon(Icons.g_translate),
                            title: Text("App Language"),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                          ListTile(
                            iconColor: Color(0xff88704e),
                            minTileHeight: 75,
                            leading: Icon(Icons.location_on),
                            title: Text("Location by GPS"),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                          InkWell(
                            onTap: () {
                              loginController.logOut();
                            },
                            child: ListTile(
                              iconColor: Color(0xff88704e),
                              minTileHeight: 75,
                              leading: Icon(Icons.logout_outlined),
                              title: Text("Log Out"),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * .3,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(71.5)),
                  child: Image.asset(
                    "assets/image/profile.png",
                    fit: BoxFit.cover,
                    width: 143,
                    height: 143,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
