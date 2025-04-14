class HajjDataList {
  final List<HajjCategory> categories;

  HajjDataList({required this.categories});

  factory HajjDataList.fromJson(List<dynamic> json) {
    return HajjDataList(
      categories:
          json.map((category) => HajjCategory.fromJson(category)).toList(),
    );
  }
}

class HajjCategory {
  final int id;
  final String name;
  final String image;
  final List<HajjItem> items;

  HajjCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.items,
  });

  factory HajjCategory.fromJson(Map<String, dynamic> json) {
    return HajjCategory(
      id: _parseInt(json['id']),
      name: json['sub_category_name']?.toString() ?? 'Unnamed Category',
      image: json['image']?.toString() ?? '',
      items: (json['data'] as List? ?? [])
          .map((e) => HajjItem.fromJson(e))
          .toList(),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

class HajjItem {
  final int id;
  final String title;
  final String content;
  final String image;
  final List<HajjSubItem> subItems;

  HajjItem({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.subItems,
  });

  factory HajjItem.fromJson(Map<String, dynamic> json) {
    return HajjItem(
      id: HajjCategory._parseInt(json['id']),
      title: json['product_name']?.toString() ?? 'Untitled Item',
      content: json['content']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      subItems: (json['sub_data'] as List? ?? [])
          .map((e) => HajjSubItem.fromJson(e))
          .toList(),
    );
  }
}

class HajjSubItem {
  final String title;
  final String description;
  final String? image;

  HajjSubItem({
    required this.title,
    required this.description,
    this.image,
  });

  factory HajjSubItem.fromJson(Map<String, dynamic> json) {
    return HajjSubItem(
      title: json['sub_title']?.toString() ?? 'Untitled Subitem',
      description: json['description']?.toString() ?? '',
      image: json['sub_image']?.toString(),
    );
  }
}
