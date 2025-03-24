import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hajj/pages/detailsSection.dart';
import 'package:http/http.dart' as http;
import 'package:hajj/pages/favourites.dart'; // Import the favorites utility

class Ziyarat extends StatefulWidget {
  const Ziyarat({super.key});

  @override
  State<Ziyarat> createState() => _ZiyaratState();
}

class _ZiyaratState extends State<Ziyarat> {
  List _itemsJson = [];
  Set<String> favoriteIds = {}; // Store favorite IDs

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    fetchJson();
    _loadFavorites();
  }

  Future<void> fetchJson() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http
          .get(
              Uri.parse("http://famtechglobal.com/arkan/public/get_content/41"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _itemsJson = data["data"] ?? [];
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
    } catch (e) {
      setState(() {
        _errorMessage = "Something went wrong. Try again!!";
        _isLoading = false;
      });
    }
  }

  /// Load favorite IDs from SharedPreferences
  Future<void> _loadFavorites() async {
    List<String> favorites = await Favourites.getFavorites();
    setState(() {
      favoriteIds = favorites.toSet();
    });
  }

  /// Toggle favorite status
  Future<void> _toggleFavorite(String id) async {
    if (favoriteIds.contains(id)) {
      await Favourites.removeFavorite(id);
    } else {
      await Favourites.addFavorite(id);
    }
    _loadFavorites(); // Refresh UI
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
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _itemsJson.length,
            itemBuilder: (context, index) {
              String itemId = _itemsJson[index]["id"].toString();
              bool isFavorite = favoriteIds.contains(itemId);

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              detailSection(id: _itemsJson[index]["id"]),
                        ),
                      );
                    },
                    title: Text(
                      _itemsJson[index]["product_name"],
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border_outlined,
                        color: isFavorite ? Colors.yellow : Colors.black,
                      ),
                      onPressed: () => _toggleFavorite(itemId),
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text(
            "No data available",
            style: TextStyle(color: Colors.white),
          ));
  }
}
