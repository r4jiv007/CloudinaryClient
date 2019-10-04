library cloudinary_client;

import 'package:cloudinary_client/models/CloudinaryResponse.dart';
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

  Future<CloudinaryResponse> uploadImage(String imagePath,
      {String filename, String folder}) async {
    return _client.uploadImage(imagePath,
        imageFilename: filename, folder: folder);
  }

  Future<List<CloudinaryResponse>> uploadImages(List<String> imagePaths,
      {String filename, String folder}) async {
    List<CloudinaryResponse> responses = List();

    for (var path in imagePaths) {
      CloudinaryResponse resp = await _client.uploadImage(path,
          imageFilename: filename, folder: folder);
      responses.add(resp);
    }
    return responses;
  }

  Future<List<String>> uploadImagesStringResp(List<String> imagePaths,
      {String filename, String folder}) async {
    List<String> responses = List();

    for (var path in imagePaths) {
      CloudinaryResponse resp = await _client.uploadImage(path,
          imageFilename: filename, folder: folder);
      responses.add(resp.url);
    }
    return responses;
  }
}
