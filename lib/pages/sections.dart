// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hajj/pages/indexSection.dart';
import 'package:rxdart/rxdart.dart';

import 'package:http/http.dart' as http;

class Sections extends StatefulWidget {
  var id;
  Sections({super.key, required this.id});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  var _selectedIndex;
  List _itemsJson = [];
  List<bool> _selected = List.generate(20, (index) => index == 0);
  final BehaviorSubject<int> _idController = BehaviorSubject<int>();
  var image;
  var name;
  bool _isLoading = true;
  String? _errorMessage;

  Future<void> fetchJson() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http
          .get(
            Uri.parse(
                "http://famtechglobal.com/arkan/public/get_subcategory/${widget.id}"),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _itemsJson = data["data"] ?? [];
          if (_itemsJson.isNotEmpty) {
            _selectedIndex = _itemsJson[0]["id"];
            image = _itemsJson[0]["image"];
            name = _itemsJson[0]["sub_category_name"];
            _idController.add(_selectedIndex);
          }
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Server error: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } on TimeoutException {
      setState(() {
        _errorMessage = "Request timed out. Check your internet connection";
        _isLoading = false;
      });
    } on http.ClientException catch (e) {
      setState(() {
        print(e);
        _errorMessage = "Something went wrong. Try again!!";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        print(e);
        _errorMessage = "Something went wrong. Try again!!";
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchJson();
  }

  @override
  void didUpdateWidget(covariant Sections oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      // If ID changes and it refetches data
      fetchJson();
    }
  }

  @override
  void dispose() {
    _idController.close(); // Close the BehaviorSubject
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 35, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchJson,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    return _itemsJson.isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 30),
                  itemCount: _itemsJson.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          // Update the selected index
                          _selectedIndex = _itemsJson[index]["id"];
                          image = _itemsJson[index]["image"];
                          name = _itemsJson[index]["sub_category_name"];

                          // Update the selection state
                          for (var i = 0; i < _selected.length; i++) {
                            _selected[i] = (i == index);
                          }

                          // Notify the indexSection widget about the new selection
                          _idController.add(_selectedIndex);
                        });
                      },
                      contentPadding: EdgeInsets.only(bottom: 5),
                      visualDensity: VisualDensity.compact,
                      selected: _selected[index],
                      title: SvgPicture.network(
                        "http://famtechglobal.com/arkan/public/images/${_itemsJson[index]["image"]}",
                        height: 30,
                        width: 30,
                        colorFilter: ColorFilter.mode(
                          _selected[index] ? Colors.amber : Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: indexSection(
                  name: name,
                  image: image,
                  idStream: _idController.stream,
                ),
              ),
            ],
          )
        : const Center(child: Text("No data available"));
  }
}
