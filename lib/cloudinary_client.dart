library cloudinary_client;

import 'package:dio/dio.dart';

import 'data/ImageClient.dart';

class CloudinaryClient {
  String _apiKey;
  String _apiSecret;
  String _cloudName;
  ImageClient _client;

  CloudinaryClient(String apiKey, String apiSecret, String cloudName) {
    this._apiKey = apiKey;
    this._apiSecret = apiSecret;
    this._cloudName = cloudName;
    _client = ImageClient(_apiKey, _apiSecret, _cloudName);
  }

  Future<Response> uploadImage(String imagePath,
      {String filename, String folder}) async {
    return _client.uploadImage(imagePath, filename: filename, folder: folder);
  }
}
