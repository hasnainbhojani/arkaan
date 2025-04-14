import 'package:flutter/material.dart';
import '../models/hajj_data.dart';
import '../services/image_cache.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final HajjDataList data;

  const CategoryPage({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: data.categories.length,
        itemBuilder: (context, index) => _buildCategory(data.categories[index]),
      ),
    );
  }

  Widget _buildCategory(HajjCategory category) {
    return Card(
      child: Column(
        children: [
          ImageCachee.cachedImage(category.image, height: 200),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(category.name, style: const TextStyle(fontSize: 20)),
                ...category.items.map(_buildItem),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(HajjItem item) {
    return ExpansionTile(
      title: Text(item.title),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ImageCachee.cachedImage(item.image, height: 150),
              Text(item.content),
              ...item.subItems.map(_buildSubItem),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubItem(HajjSubItem subItem) {
    return ListTile(
      leading: subItem.image != null
          ? ImageCachee.cachedImage(subItem.image!, width: 40)
          : null,
      title: Text(subItem.title),
      subtitle: Text(subItem.description),
    );
  }
}
