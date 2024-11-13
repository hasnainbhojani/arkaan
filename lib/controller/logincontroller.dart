// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/home.dart';
import 'package:hajj/pages/register.dart';
import 'package:hajj/pages/splash.dart';
import 'package:hajj/widgets/bottomNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController r_email = TextEditingController();
  TextEditingController r_password = TextEditingController();

  String LOGINKEY = "isLogin";
  bool? isLogin = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    skipLogin();
  }

  void login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGINKEY, true);
    print(email);
    print(password);
    Get.to(() => navMenu());
  }

  void register() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGINKEY, true);
    print(name);
    print(mobile);
    print(r_email);
    print(r_password);
    Get.to(() => navMenu());
  }

  void skipLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool(LOGINKEY);

    if (isLogin == true) {
      Get.to(() => navMenu());
    } else {
      Get.to(() => splashScreen());
    }
  }

  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGINKEY, false);
    Get.to(() => splashScreen());
  }
}
