// search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hajj/config/api_config.dart';
import '../models/hajj_data.dart';
import 'detailsSection.dart';

class SearchPage extends StatefulWidget {
  final Map<String, HajjDataList> allData;

  const SearchPage({super.key, required this.allData});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];

  String styleHtmlText(String htmlText) {
    // Apply styles dynamically
    return htmlText.replaceAllMapped(RegExp(r'[\u0600-\u06FF]+'), (match) {
      // Arabic Text
      return '<span style="font-family: Quranicfont, sans-serif; font-size:20; line-height: 2.0; ">${match.group(0)}</span>';
    }).replaceAllMapped(RegExp(r'[\u0A80-\u0AFF]+'), (match) {
      // Gujarati Text
      return '<span style="font-family: MuktaVaani, font-size:20, sans-serif;">${match.group(0)}</span>';
    });
  }

  void _performSearch(String query) {
    final results = <SearchResult>[];
    final cleanQuery = query.trim().toLowerCase();

    if (cleanQuery.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    widget.allData.forEach((categoryKey, hajjData) {
      final categoryConfig = ApiConfig.endpoints.firstWhere(
        (e) => e['key'] == categoryKey,
        orElse: () => {'name': 'Unknown Category'},
      );

      for (final category in hajjData.categories) {
        // Search category name
        _addResultIfMatches(
          category.name,
          categoryConfig['name']!,
          category,
          null,
          null,
          results,
          cleanQuery,
        );

        // Search items
        for (final item in category.items) {
          _addResultIfMatches(
            item.title,
            categoryConfig['name']!,
            category,
            item,
            null,
            results,
            cleanQuery,
          );
          _addResultIfMatches(
            item.content,
            categoryConfig['name']!,
            category,
            item,
            null,
            results,
            cleanQuery,
          );

          // Search sub-items
          for (final subItem in item.subItems) {
            _addResultIfMatches(
              subItem.title,
              categoryConfig['name']!,
              category,
              item,
              subItem,
              results,
              cleanQuery,
            );
            _addResultIfMatches(
              subItem.description,
              categoryConfig['name']!,
              category,
              item,
              subItem,
              results,
              cleanQuery,
            );
          }
        }
      }
    });

    setState(() => _searchResults = results);
  }

  void _addResultIfMatches(
    String text,
    String mainCategory,
    HajjCategory category,
    HajjItem? item,
    HajjSubItem? subItem,
    List<SearchResult> results,
    String query,
  ) {
    if (text.toLowerCase().contains(query)) {
      results.add(SearchResult(
        matchedText: text,
        mainCategory: mainCategory,
        subCategory: category.name,
        category: category,
        item: item,
        subItem: subItem,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search in Gujarati or Arabic...',
            border: InputBorder.none,
          ),
          onChanged: _performSearch,
          autofocus: true,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.isEmpty) {
      return const Center(
          child: Text(
        'Start typing to search',
        style: TextStyle(color: Colors.white),
      ));
    }

    if (_searchResults.isEmpty) {
      return const Center(
          child: Text(
        'No results found',
        style: TextStyle(color: Colors.white),
      ));
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            onTap: () => _navigateToResult(result),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.subCategory,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                _buildHighlightedText(
                    result.matchedText, _searchController.text),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHighlightedText(String fullText, String query) {
    final text = fullText;
    final queryLower = query.toLowerCase();
    final startIndex = text.toLowerCase().indexOf(queryLower);
    const snippetLength = 100;

    String snippet;
    if (startIndex == -1) {
      snippet = text.length > snippetLength
          ? '${text.substring(0, snippetLength)}...'
          : text;
      return HtmlWidget(styleHtmlText(snippet));
    }

    final endIndex = startIndex + query.length;
    final startSnippet = startIndex - 20 > 0 ? startIndex - 20 : 0;
    final endSnippet =
        endIndex + 80 < text.length ? endIndex + 80 : text.length;

    snippet = text.substring(startSnippet, endSnippet);
    if (startSnippet > 0) snippet = '...$snippet';
    if (endSnippet < text.length) snippet = '$snippet...';

    final relativeStart =
        startIndex - startSnippet + (startSnippet > 0 ? 3 : 0);
    final relativeEnd = relativeStart + query.length;

    return Card(
      color: Colors.grey.shade700,
      child: Column(
        children: [
          HtmlWidget(
            styleHtmlText(snippet.substring(0, relativeStart)),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          HtmlWidget(
            styleHtmlText(snippet.substring(relativeStart, relativeEnd)),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.red.shade300,
              fontSize: 20,
            ),
          ),
          HtmlWidget(
            styleHtmlText(snippet.substring(relativeEnd)),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToResult(SearchResult result) {
    if (result.subItem != null && result.item != null) {
      final subItemIndex = result.item!.subItems.indexOf(result.subItem!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailSection(
            item: result.item!,
            subItemIndex: subItemIndex,
          ),
        ),
      );
    } else if (result.item != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailSection(item: result.item!),
        ),
      );
    } else if (result.category != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailSection(
            item: result.category!.items.first,
          ),
        ),
      );
    }
  }
}

class SearchResult {
  final String matchedText;
  final String mainCategory;
  final String subCategory;
  final HajjCategory? category;
  final HajjItem? item;
  final HajjSubItem? subItem;

  SearchResult({
    required this.matchedText,
    required this.mainCategory,
    required this.subCategory,
    this.category,
    this.item,
    this.subItem,
  });
}
