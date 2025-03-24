import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'detailsSection.dart';

class Favourites {
  static const String _favoritesKey = 'favorites';

  /// Save favorite ID to SharedPreferences
  static Future<void> addFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (!favorites.contains(id)) {
      favorites.add(id);
      await prefs.setStringList(_favoritesKey, favorites);
      print("Saved Favorites: $favorites");
    }
  }

  /// Remove favorite ID from SharedPreferences
  static Future<void> removeFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.remove(id);
    await prefs.setStringList(_favoritesKey, favorites);
    print("Updated Favorites: $favorites");
  }

  /// Get all saved favorite IDs
  static Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    print("Retrieved Favorites: $favorites");
    return favorites;
  }
}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favoriteIds = []; // Stored favorite IDs
  List favoriteItems = []; // Fetched favorite data
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  /// Load favorite IDs and fetch details for each
  Future<void> _loadFavorites() async {
    favoriteIds = await Favourites.getFavorites();
    print("Loaded Favorite IDs: $favoriteIds");
    if (favoriteIds.isNotEmpty) {
      await _fetchFavoriteItems();
    } else {
      setState(() {
        favoriteItems = [];
        isLoading = false;
      });
    }
  }

  /// Fetch details of each saved ID from API
  Future<void> _fetchFavoriteItems() async {
    List<dynamic> items = []; // Initialize outside the loop
    for (String id in favoriteIds) {
      final url = Uri.parse(
          "http://famtechglobal.com/arkan/public/get_content_details/$id");
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data.containsKey("data") && data["data"] is Map) {
            items.add(data["data"]); // Append to the list
          }
        }
      } catch (e) {
        print("Error fetching favorite item $id: $e");
      }
    }

    setState(() {
      favoriteItems = items; // Now contains all fetched items
      isLoading = false;
    });
  }

  /// Remove an item from favorites
  Future<void> _removeFavorite(String id) async {
    await Favourites.removeFavorite(id);
    _loadFavorites(); // Reload favorites
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Favorites")),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : favoriteItems.isEmpty
                ? Center(
                    child: Text(
                    "No favorites added yet!",
                    style: TextStyle(color: Colors.white),
                  ))
                : ListView.builder(
                    itemCount: favoriteItems.length,
                    itemBuilder: (context, index) {
                      var item = favoriteItems[index]; // Directly a Map
                      String itemId = item["id"].toString(); // No [0] needed

                      return Card(
                        color: Colors.grey,
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://famtechglobal.com/arkan/public/images/${item["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item["product_name"] ?? "No Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MuktaVaani',
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeFavorite(itemId),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      detailSection(id: itemId),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ));
  }
}
