import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/hajj_data.dart';
import 'image_cache.dart';

class DataService {
  static const String _boxName = 'hajjData';

  static Future<Map<String, HajjDataList>> fetchAllData(
      List<Map<String, String>> endpoints) async {
    final Map<String, HajjDataList> results = {};

    await Future.wait(
      endpoints.map((endpoint) async {
        try {
          final data = await _fetchEndpointData(endpoint);
          results[endpoint['key']!] = data;
          await _cacheImages(data);
        } catch (e) {
          print('Error loading ${endpoint['name']}: $e');
        }
      }),
    );

    return results;
  }

  static Future<HajjDataList> _fetchEndpointData(
      Map<String, String> endpoint) async {
    try {
      final response = await http
          .get(Uri.parse(endpoint['url']!))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        await _cacheData(endpoint, response.body);
        return HajjDataList.fromJson(jsonData);
      }
      throw HttpException('Request failed: ${response.statusCode}');
    } catch (e) {
      final cachedData = await _getCachedData(endpoint);
      if (cachedData != null) return cachedData;
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<void> _cacheData(
      Map<String, String> endpoint, String rawJson) async {
    final box = await Hive.openBox(_boxName);
    await box.put(endpoint['key'], rawJson);
    await box.put(
        '${endpoint['key']}_lastUpdated', DateTime.now().toIso8601String());
  }

  static Future<HajjDataList?> _getCachedData(
      Map<String, String> endpoint) async {
    try {
      final box = await Hive.openBox(_boxName);
      final rawJson = box.get(endpoint['key']);
      if (rawJson != null) {
        return HajjDataList.fromJson(json.decode(rawJson));
      }
      return null;
    } catch (e) {
      print('Cache error for ${endpoint['key']}: $e');
      return null;
    }
  }

  static Future<void> _cacheImages(HajjDataList data) async {
    try {
      final images = await ImageCachee.extractAllImages(data);
      await Future.wait(
        images.map((imageUrl) => ImageCachee.cacheNetworkImage(imageUrl)),
      );
    } catch (e) {
      print('Image caching error: $e');
    }
  }
}
