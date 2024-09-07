// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool passwordVisible = false;

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
              Column(
                children: [
                  // Title
                  Text(
                    "REGISTER",
                    style: TextStyle(color: Color(0xff88704e), fontSize: 32),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Name Field
                  TextField(
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
                        "Full Name",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      focusColor: Color(0xff88704e),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: Color(0xff88704e),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Mobile Field
                  TextField(
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
                        "Mobile Number",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      focusColor: Color(0xff88704e),
                    ),
                    keyboardType: TextInputType.phone,
                    cursorColor: Color(0xff88704e),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Email Field
                  TextField(
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
                  SizedBox(
                    height: 20,
                  ),
                  // Register Button
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xff88704e),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "Login",
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
