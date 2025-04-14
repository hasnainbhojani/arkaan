import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hajj/config/api_config.dart';
import 'package:hajj/models/hajj_data.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:connectivity_plus/connectivity_plus.dart';

class ImageCachee {
  static const String _svgPrefix = 'svg_';
  static const String _imagePrefix = 'img_';
  static final Connectivity _connectivity = Connectivity();

  static Future<String> _getLocalPath(String filename, bool isSvg) async {
    final directory = await getApplicationDocumentsDirectory();
    final prefix = isSvg ? _svgPrefix : _imagePrefix;
    return '${directory.path}/$prefix$filename';
  }

  static Future<void> cacheNetworkImage(String imagePath) async {
    try {
      final isSvg = imagePath.toLowerCase().endsWith('.svg');
      final filename = path.basename(imagePath);
      final localPath = await _getLocalPath(filename, isSvg);
      final file = File(localPath);

      if (await file.exists()) return;

      final response =
          await http.get(Uri.parse(ApiConfig.imageBaseUrl + imagePath));

      if (isSvg) {
        // Validate and format SVG content
        final sanitized = _sanitizeSvgContent(response.body);
        await file.writeAsString(sanitized);
      } else {
        await file.writeAsBytes(response.bodyBytes);
      }
    } catch (e) {
      print('Image cache failed: $e');
    }
  }

  static String _sanitizeSvgContent(String content) {
    // Basic SVG validation and formatting
    if (!content.startsWith('<svg')) {
      throw FormatException('Invalid SVG content');
    }
    return content;
  }

  static Widget cachedImage(
    String imagePath, {
    double? width,
    double? height,
    Color? color, // Add color parameter
  }) {
    return FutureBuilder<bool>(
      future: _isConnected(),
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? false;
        return FutureBuilder<File>(
          future: _getCachedFile(imagePath),
          builder: (context, fileSnapshot) {
            final file = fileSnapshot.data;
            final exists = file?.existsSync() ?? false;

            Widget imageWidget = _buildImageWidget(
              file ?? File(''),
              width,
              height,
              color, // Pass color to image widget
            );

            if (!exists && !isOnline) {
              return _buildPlaceholder(width, height);
            }

            if (!exists && isOnline) {
              return FutureBuilder<void>(
                future: cacheNetworkImage(imagePath),
                builder: (context, cacheSnapshot) {
                  if (cacheSnapshot.connectionState == ConnectionState.done) {
                    return _buildImageWidget(
                      file ?? File(''),
                      width,
                      height,
                      color,
                    );
                  }
                  return _buildProgressIndicator(width, height);
                },
              );
            }

            return imageWidget;
          },
        );
      },
    );
  }

  // static Widget cachedImage(String imagePath, {double? width, double? height}) {
  //   return FutureBuilder<bool>(
  //     future: _isConnected(),
  //     builder: (context, snapshot) {
  //       final isOnline = snapshot.data ?? false;
  //       return FutureBuilder<File>(
  //         future: _getCachedFile(imagePath),
  //         builder: (context, fileSnapshot) {
  //           if (fileSnapshot.hasData && fileSnapshot.data!.existsSync()) {
  //             return _buildImageWidget(fileSnapshot.data!, width, height);
  //           }

  //           if (!isOnline) {
  //             return _buildPlaceholder(width, height);
  //           }

  //           return FutureBuilder<void>(
  //             future: cacheNetworkImage(imagePath),
  //             builder: (context, cacheSnapshot) {
  //               if (cacheSnapshot.connectionState == ConnectionState.done) {
  //                 if (cacheSnapshot.hasError) {
  //                   return _buildPlaceholder(width, height);
  //                 }
  //                 return _buildImageWidget(
  //                     File(fileSnapshot.data!.path), width, height);
  //               }
  //               return _buildProgressIndicator(width, height);
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  static Future<File> _getCachedFile(String imagePath) async {
    final isSvg = imagePath.toLowerCase().endsWith('.svg');
    final filename = path.basename(imagePath);
    final localPath = await _getLocalPath(filename, isSvg);
    return File(localPath);
  }

  static Widget _buildImageWidget(
    File file,
    double? width,
    double? height,
    Color? color,
  ) {
    final isSvg = file.path.contains(_svgPrefix);

    if (isSvg) {
      return SvgPicture.file(
        file,
        width: width,
        height: height,
        color: color, // Directly use color property for SVG
        placeholderBuilder: (context) => _buildProgressIndicator(width, height),
      );
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: Image.file(
            file,
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
        ),
        if (color != null)
          Container(
            width: width,
            height: height,
            color: color.withOpacity(0.3), // Overlay color for non-SVG
          ),
      ],
    );
  }

  static Future<bool> _isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static Widget _buildPlaceholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
    );
  }

  static Widget _buildProgressIndicator(double? width, double? height) {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  static Future<List<String>> extractAllImages(HajjDataList data) async {
    final images = <String>[];
    try {
      for (final category in data.categories) {
        images.add(category.image);
        for (final item in category.items) {
          images.add(item.image);
          for (final subItem in item.subItems) {
            if (subItem.image != null) {
              images.add(subItem.image!);
            }
          }
        }
      }
      return images.toSet().toList(); // Remove duplicates
    } catch (e) {
      print('Image extraction error: $e');
      return [];
    }
  }
}
