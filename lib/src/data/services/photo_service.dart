import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Response, get;

const _photoAPI = 'https://november7-730026606190.europe-west1.run.app/image/';

abstract class BasePhotoService {
  Future<String> getPhotoUrl();
  Future<Uint8List?> getPhotoBytes(String imageUrl);
}

class PhotoService extends BasePhotoService {
  // static singleton
  static final PhotoService _instance = PhotoService.internal();

  factory PhotoService() => _instance;

  PhotoService.internal();

  @override
  Future<String> getPhotoUrl() async {
    try {
      debugPrint('_PhotoApi: $_photoAPI');
      final Response response = await get(Uri.parse(_photoAPI));

      debugPrint('body: ${response.body}');
      if (response.statusCode == 200) {
        final photoUrl = jsonDecode(response.body);
        return photoUrl['url'];
      }
      debugPrint('_PhotoApi no data:');
      return '';
    } catch (e) {
      debugPrint('_PhotoApi error: $e');
      return '';
    }
  }

  @override
  Future<Uint8List?> getPhotoBytes(String imageUrl) async {
    try {
      debugPrint('_PhotoApi: $imageUrl');
      final response = await get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      debugPrint('_PhotoApi no data:');
      return null;
    } catch (e) {
      debugPrint('_PhotoApi error: $e');
      return null;
    }
  }
}
