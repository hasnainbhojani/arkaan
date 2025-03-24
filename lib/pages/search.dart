import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  List<dynamic> _allItems = [];
  bool _isLoading = false;

// First function: Fetch all subcategories (IDs)
  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("http://famtechglobal.com/arkan/public/get_subcategory/1"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _allItems = data["data"] ?? [];
        // Pre-fetch content for all IDs (optional)
        await _fetchContentForAllIds();
      }
    } catch (e) {
      print("Error fetching initial data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// Second function: Fetch content for a specific ID
  Future<dynamic> _fetchContentForId(int id) async {
    try {
      final response = await http.get(
        Uri.parse("http://famtechglobal.com/arkan/public/get_content/$id"),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      }
    } catch (e) {
      print("Error fetching content for ID $id: $e");
    }
    return null;
  }

// Fetch content for all IDs
  Future<void> _fetchContentForAllIds() async {
    List<Future<dynamic>> futures = [];
    for (var item in _allItems) {
      futures.add(_fetchContentForId(item["id"]));
    }
    // Wait for all requests to complete
    final results = await Future.wait(futures);
    _searchResults = results.where((result) => result != null).toList();
  }

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Filter results locally (or fetch from API)
    final filtered = _allItems.where((item) {
      final productName = item["product_name"]?.toString().toLowerCase() ?? "";
      return productName.contains(query.toLowerCase());
    }).toList();

    // If you need to fetch from API for each ID:
    // await _fetchContentForAllIds();
    // Then filter _searchResults

    setState(() {
      _searchResults = filtered;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch all items when the page initializes
    _fetchInitialData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Search...",
            focusColor: Colors.white,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          onChanged: (query) {
            _performSearch(query);
          },
        ),
      ),
      body: Column(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _searchResults.isEmpty
                  ? const Center(child: Text("No results found"))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final item = _searchResults[index];
                        return ListTile(
                          title: Text(item["product_name"] ?? "No Name"),
                          subtitle:
                              Text(item["description"] ?? "No Description"),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
