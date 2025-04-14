import 'package:flutter/material.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:hajj/pages/detailsSection.dart';
import 'package:hajj/services/favourites_service.dart';
import 'package:hajj/services/image_cache.dart';

class IndexSection extends StatefulWidget {
  final HajjCategory category;
  final Stream<int> idStream;

  const IndexSection({
    super.key,
    required this.category,
    required this.idStream,
  });

  @override
  State<IndexSection> createState() => _IndexSectionState();
}

class _IndexSectionState extends State<IndexSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category Header
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageCachee.cachedImage(widget.category.image,
                  height: 26, width: 26),
              SizedBox(
                width: 5,
              ),
              Text(
                widget.category.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // StreamView List
        Expanded(
          child: StreamBuilder<int>(
            stream: widget.idStream,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: widget.category.items.length,
                itemBuilder: (context, index) {
                  final item = widget.category.items[index];
                  return _buildItemCard(context, item);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(BuildContext context, HajjItem item) {
    return FutureBuilder<List<String>>(
      future: FavoritesService.getFavorites(),
      builder: (context, snapshot) {
        final isFavorite =
            snapshot.hasData && snapshot.data!.contains(item.id.toString());

        return InkWell(
          onTap: () => _navigateToDetail(context, item),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border_outlined,
                          color: isFavorite ? Colors.amber : Colors.grey,
                          size: 18,
                        ),
                        onPressed: () => _toggleFavorite(item.id.toString()),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black, height: 1),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 3.0, left: 3.0, right: 3.0),
                  child: ImageCachee.cachedImage(
                    item.image,
                    height: 110,
                    width: double.maxFinite, //310
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleFavorite(String itemId) async {
    await FavoritesService.toggleFavorite(itemId);
    setState(() {});
  }

  void _navigateToDetail(BuildContext context, HajjItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailSection(item: item),
      ),
    );
  }
}
