import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:hajj/pages/indexSection.dart';
import 'package:hajj/services/data_service.dart';
import 'package:hajj/services/image_cache.dart';

class Sections extends StatefulWidget {
  final HajjDataList hajjData;

  const Sections({super.key, required this.hajjData});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  late int _selectedCategoryIndex;
  final _idController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Hajj Guide'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: () => _refreshData(context),
      //     ),
      //   ],
      // ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category List
              Expanded(
                flex: 1,
                child: _buildCategoryList(widget.hajjData.categories),
              ),

              // Content Section
              Expanded(
                flex: 5,
                child: IndexSection(
                  category: widget.hajjData.categories[_selectedCategoryIndex],
                  idStream: _idController.stream,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _refreshData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Refreshing Data..."),
          ],
        ),
      ),
    );

    DataService.fetchAllData().then((newData) {
      Navigator.pop(context); // Close loading dialog
      setState(() {
        _selectedCategoryIndex = 0;
      });
    }).catchError((error) {
      Navigator.pop(context); // Close loading dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to refresh: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCategoryList(List<HajjCategory> categories) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 40),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          onTap: () {
            setState(() => _selectedCategoryIndex = index);
            _idController.add(categories[index].id);
          },
          selected: _selectedCategoryIndex == index,
          contentPadding: const EdgeInsets.only(bottom: 10),
          visualDensity: VisualDensity.compact,
          title: ImageCachee.cachedImage(
            category.image,
            height: 32,
            width: 32,
            color:
                _selectedCategoryIndex == index ? Colors.amber : Colors.white,
          ),
        );
      },
    );
  }
}
