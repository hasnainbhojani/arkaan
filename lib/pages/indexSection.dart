import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/favourites.dart';
import 'package:http/http.dart' as http;
import 'detailsSection.dart';

class indexSection extends StatefulWidget {
  final Stream<int> idStream;
  var name;
  var image;

  indexSection(
      {Key? key,
      required this.idStream,
      required this.image,
      required this.name})
      : super(key: key);

  @override
  State<indexSection> createState() => _indexSectionState();
}

class _indexSectionState extends State<indexSection> {
  final StreamController<List> _streamController = StreamController<List>();
  late StreamSubscription<int> _idSubscription;
  Set<String> favoriteIds = {};

  @override
  void initState() {
    super.initState();
    _idSubscription = widget.idStream.listen((id) {
      fetchJson(id);
    });
    _loadFavorites();
  }

  Future<void> fetchJson(int id) async {
    print("Fetching for ID: $id");
    final url =
        Uri.parse("http://famtechglobal.com/arkan/public/get_content/$id");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List fetchedData = data["data"] ?? [];
        _streamController.sink.add(fetchedData);
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      _streamController.sink.addError("Error fetching data: $e");
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
  void dispose() {
    _streamController.close();
    _idSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.network(
                "http://famtechglobal.com/arkan/public/images/${widget.image}",
                height: 32,
                width: 32,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                widget.name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'MuktaVaani',
                    fontSize: 12),
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          StreamBuilder<List>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  child: Center(
                    child: Text(
                      "No data found.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                var items = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      String itemId = items[index]["id"]
                          .toString(); // Convert ID to string for consistency
                      bool isFavorite = favoriteIds.contains(itemId);

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  detailSection(id: items[index]["id"]),
                            ),
                          );
                        },
                        child: Container(
                          // Background color
                          margin: const EdgeInsets.all(
                              4.0), // Add margin for spacing
                          padding: const EdgeInsets.all(
                              4.0), // Add padding inside the container
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      items[index]["product_name"] ?? "No Name",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.star
                                          : Icons.star_border_outlined,
                                      color: isFavorite
                                          ? Colors.yellow
                                          : Colors.black,
                                      size: 18.0,
                                    ),
                                    onPressed: () => _toggleFavorite(itemId),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                                height: 1,
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    "http://famtechglobal.com/arkan/public/images/${items[index]["image"]}",
                                placeholder: null,
                                errorWidget: (context, url, error) =>
                                    const Text("Image not available"),
                                height: 110,
                                width: 310,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                        // child: Card(
                        //   color: Colors.white,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(2.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Flexible(
                        //               child: Text(
                        //                 items[index]["product_name"] ??
                        //                     "No Name",
                        //                 style: const TextStyle(
                        //                     color: Colors.black,
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //             ),
                        //             IconButton(
                        //               icon: Icon(
                        //                 isFavorite
                        //                     ? Icons.star
                        //                     : Icons.star_border_outlined,
                        //                 color: isFavorite
                        //                     ? Colors.yellow
                        //                     : Colors.black,
                        //                 size: 18.0,
                        //               ),
                        //               onPressed: () =>
                        //                   _toggleFavorite(itemId),
                        //             ),
                        //           ],
                        //         ),
                        //         const Divider(
                        //           color: Colors.black,
                        //           height: 1,
                        //         ),
                        //         ClipRRect(
                        //           borderRadius: BorderRadius.circular(10),
                        //           child: CachedNetworkImage(
                        //             imageUrl:
                        //                 "http://famtechglobal.com/arkan/public/images/${items[index]["image"]}",
                        //             placeholder: null,
                        //             errorWidget: (context, url, error) =>
                        //                 const Text("Image not available"),
                        //             height: 130,
                        //             width: 300,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      );
                    },
                  ),
                );
              }
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
