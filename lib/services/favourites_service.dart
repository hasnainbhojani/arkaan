import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_items';

  static Future<void> toggleFavorite(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (favorites.contains(itemId)) {
      favorites.remove(itemId);
    } else {
      favorites.add(itemId);
    }

    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }
}
