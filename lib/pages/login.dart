// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/controller/logincontroller.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool passwordVisible = false;
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      passwordVisible = false;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Logo
              Image.asset(
                "assets/image/arkan.png",
                height: 40,
                width: 120,
              ),
              // Title
              Text(
                "LOGIN",
                style: TextStyle(color: Color(0xff88704e), fontSize: 32),
              ),
              Column(
                children: [
                  // Email Field
                  TextField(
                    controller: loginController.email,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Color(0xff88704e)),
                      ),
                      label: Text(
                        "Email",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.black,
                      ),
                      focusColor: Color(0xff88704e),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xff88704e),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Password Field
                  TextField(
                    controller: loginController.password,
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Color(0xff88704e)),
                      ),
                      label: Text(
                        "Password",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      focusColor: Color(0xff88704e),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xff88704e),
                  ),
                ],
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(color: Color(0xff88704e), fontSize: 14),
              ),
              // Login Button
              InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                onTap: () {
                  loginController.login();
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xff88704e),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(color: Color(0xff88704e), fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
