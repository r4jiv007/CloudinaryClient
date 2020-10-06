library cloudinary_imageClient;

import 'data/ImageClient.dart';
import 'data/VideoClient.dart';
import 'models/CloudinaryResponse.dart';

class CloudinaryClient {
  String _apiKey;
  String _apiSecret;
  String _cloudName;
  ImageClient _imageClient;
  VideoClient _videoClient;

  CloudinaryClient(String apiKey, String apiSecret, String cloudName) {
    this._apiKey = apiKey;
    this._apiSecret = apiSecret;
    this._cloudName = cloudName;
    _imageClient = ImageClient(_apiKey, _apiSecret, _cloudName);
    _videoClient = VideoClient(_apiKey, _apiSecret, _cloudName);
  }

  Future<CloudinaryResponse> uploadImage(String imagePath,
      {String filename, String folder}) async {
    return _imageClient.uploadImage(imagePath,
        imageFilename: filename, folder: folder);
  }

  Future<List<CloudinaryResponse>> uploadImages(List<String> imagePaths,
      {String filename, String folder}) async {
    List<CloudinaryResponse> responses = await Future.wait(imagePaths.map(
            (imagePath) async =>
                await _imageClient.uploadImage(imagePath, folder: folder)))
        .catchError((err) => throw (err));

    return responses;
  }

  Future<List<String>> uploadImagesStringResp(List<String> imagePaths,
      {String filename, String folder}) async {
    List<String> responses = List();

    for (var path in imagePaths) {
      CloudinaryResponse resp = await _imageClient.uploadImage(path,
          imageFilename: filename, folder: folder);
      responses.add(resp.url);
    }
    return responses;
  }

  Future<CloudinaryResponse> uploadVideo(String videoPath,
      {String filename, String folder}) async {
    return _videoClient.uploadVideo(videoPath,
        videoFileName: filename, folder: folder);
  }
}
