import 'package:flutter/material.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:hajj/pages/detailsSection.dart';
import 'package:hajj/services/favourites_service.dart';
import 'package:hajj/services/image_cache.dart';

class FavoritesPage extends StatefulWidget {
  final Map<String, HajjDataList> allData;

  const FavoritesPage({super.key, required this.allData});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<HajjItem>> _favoriteItems;

  @override
  void initState() {
    super.initState();
    _favoriteItems = _loadFavorites();
  }

  Future<List<HajjItem>> _loadFavorites() async {
    final favoriteIds = await FavoritesService.getFavorites();
    final allItems = <HajjItem>[];

    widget.allData.values.forEach((hajjData) {
      hajjData.categories.forEach((category) {
        allItems.addAll(category.items);
      });
    });

    return allItems
        .where((item) => favoriteIds.contains(item.id.toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: FutureBuilder<List<HajjItem>>(
        future: _favoriteItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              'No favorites yet',
              style: TextStyle(color: Colors.white),
            ));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: ImageCachee.cachedImage(item.image,
                      width: 40, height: 40),
                  title: Text(item.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.star, color: Colors.amber),
                    onPressed: () => _toggleFavorite(item.id.toString()),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailSection(item: item),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _toggleFavorite(String itemId) async {
    await FavoritesService.toggleFavorite(itemId);
    setState(() {
      _favoriteItems = _loadFavorites();
    });
  }
}
