// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Needed for Uri.encodeComponent

class Queries extends StatefulWidget {
  const Queries({super.key});

  @override
  State<Queries> createState() => _QueriesState();
}

class _QueriesState extends State<Queries> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _topic = TextEditingController();
  final TextEditingController _query = TextEditingController();

  Future<void> _sendGetRequest() async {
    String name = _name.text;
    String email = _email.text;
    String phone = _phone.text;
    String topic = _topic.text;
    String query = _query.text;

    // Proper URL encoding of user input
    String apiUrl = 'http://famtechglobal.com/arkan/public/save_question?'
        'name=${Uri.encodeComponent(name)}&'
        'email=${Uri.encodeComponent(email)}&'
        'phone=${Uri.encodeComponent(phone)}&'
        'topic=${Uri.encodeComponent(topic)}&'
        'message=${Uri.encodeComponent(query)}';

    print("Request URL: $apiUrl"); // Debug URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Text("Message successfully sent!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Ok")),
              ],
            );
          },
        );
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Text("Message couldn't be sent. Try again!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Ok")),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Message couldn't be sent. Try again!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Ok")),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ask your Question",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Name
            TextField(
              controller: _name,
              decoration: _inputDecoration(
                  "Type your Name", "Name", Icons.person_outlined),
              keyboardType: TextInputType.name,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(height: 20),
            // Email
            TextField(
              controller: _email,
              decoration: _inputDecoration(
                  "Type your Email", "Email", Icons.email_rounded),
              keyboardType: TextInputType.emailAddress,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(height: 20),
            // Phone
            TextField(
              controller: _phone,
              decoration: _inputDecoration(
                  "Type your phone number", "Phone number", Icons.phone),
              keyboardType: TextInputType.phone,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(height: 20),
            // Topic
            TextField(
              controller: _topic,
              decoration:
                  _inputDecoration("Type the topic", "Topic", Icons.topic),
              keyboardType: TextInputType.text,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(height: 20),
            // Query
            TextField(
              controller: _query,
              decoration: _inputDecoration(
                  "Type your query", "Your Query", Icons.text_snippet),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Color(0xff88704e),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.3),
                  side: BorderSide(color: Color(0xff88704e), width: 2)),
              onPressed: _sendGetRequest,
              child: Text(
                "Send",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Input Decoration for reuse
  InputDecoration _inputDecoration(
      String hintText, String label, IconData icon) {
    return InputDecoration(
      fillColor: Colors.white.withOpacity(0.3),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Color(0xff88704e)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Color(0xff88704e)),
      ),
      hintText: hintText,
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      prefixIcon: Icon(icon),
      focusColor: Color(0xff88704e),
    );
  }
}
